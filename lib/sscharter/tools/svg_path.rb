# frozen_string_literal: true

module Sunniesnow::Tools::SvgPath

	Vector2D = Data.define :x, :y do
		def +@
			self
		end

		def -@
			Vector2D.new -x, -y
		end

		def + other
			Vector2D.new x + other.x, y + other.y
		end

		def - other
			Vector2D.new x - other.x, y - other.y
		end

		def * other
			other.is_a?(Vector2D) ? Vector2D.new(x*other.x, y*other.y) : Vector2D.new(x*other, y*other)
		end

		def / other
			other.is_a?(Vector2D) ? Vector2D.new(x/other.x, y/other.y) : Vector2D.new(x/other, y/other)
		end

		def to_a
			[x, y]
		end

		def length
			Math.hypot x, y
		end

		def angle
			Math.atan2 y, x
		end

		def length2
			x*x + y*y
		end

		def rotate angle
			cos = Math.cos angle
			sin = Math.sin angle
			Vector2D.new x*cos - y*sin, x*sin + y*cos
		end

		def self.from_string str
			new *str.split(',').map(&:to_f)
		end

		def self.from_polar radius, angle
			new Math.cos(angle)*radius, Math.sin(angle)*radius
		end
	end

	class GeometryError < StandardError
	end

	class PathSegment
		def at t
		end

		def at_length s
		end

		def begin
		end

		def end
		end

		def length
		end
	end

	class Line < PathSegment

		attr_reader :begin
		attr_reader :end
		attr_reader :length

		def initialize begin_point, end_point
			@begin = begin_point
			@end = end_point
			@length = (@end - @begin).length
		end

		def at t
			@begin*(1-t) + @end*t
		end

		def at_length s
			at s/@length
		end
	end

	module Curve
		def length
			@lengths.last
		end

		def at_length s
			k = @lengths.bsearch_index { _1 > s } - 1
			@segments[k].at_length s - @lengths[k]
		end

		private def make_segments n
			@segments = Array.new(n) { Line.new at(_1/n.to_f), at((_1+1)/n.to_f) }
			@lengths = @segments.each_with_object([0.0]) { _2.push _2.last + _1.length }
		end
	end

	class QuadraticBezier < PathSegment
		include Curve

		attr_reader :begin
		attr_reader :control
		attr_reader :end

		def initialize begin_point, control_point, end_point, segments: 8
			@begin = begin_point
			@control = control_point
			@end = end_point
			make_segments segments
		end

		def at t
			@begin*(1-t)**2 + @control*(2*(1-t)*t) + @end*t**2
		end
	end

	class CubicBezier < PathSegment
		include Curve

		attr_reader :begin
		attr_reader :control1
		attr_reader :control2
		attr_reader :end

		def initialize begin_point, control_point1, control_point2, end_point, segments: 16
			@begin = begin_point
			@control1 = control_point1
			@control2 = control_point2
			@end = end_point
			make_segments segments
		end

		def at t
			@begin*(1-t)**3 + @control1*(3*(1-t)**2*t) + @control2*(3*(1-t)*t**2) + @end*t**3
		end
	end

	class Arc < PathSegment
		include Curve

		attr_reader :begin
		attr_reader :radius
		attr_reader :rotation
		attr_reader :large_arc
		attr_reader :sweep_positive
		attr_reader :end

		def initialize begin_point, radius, rotation, large_arc, sweep_positive, end_point, segments: 8
			@begin = begin_point
			@radius = radius
			@rotation = rotation
			@large_arc = large_arc
			@sweep_positive = sweep_positive
			@end = end_point
			raise GeometryError.new 'Radius must be positive' if @radius.x <= 0 || @radius.y <= 0
			raise GeometryError.new 'Cannot draw arc with same begin and end point' if @begin == @end
			solve_center
			make_segments segments
		end

		def at t
			@center + (Vector2D.from_polar(1, @angle1*(1-t) + @angle2*t) * @radius).rotate(@rotation)
		end

		private def solve_center
			p1 = @begin.rotate(-@rotation) / @radius
			p2 = @end.rotate(-@rotation) / @radius
			diff = p2 - p1
			if (distance2 = diff.length2) > 4
				scale = Math.sqrt(distance2)/2
				distance2 = 4
				@radius *= scale
				diff /= scale
			end
			normal = Vector2D.new -diff.y, diff.x
			sign = @large_arc == @sweep_positive ? -1 : 1
			center = (p1 + p2)/2 + normal * (sign * Math.sqrt(1.0/distance2 - 0.25))
			@angle1 = (p1 - center).angle
			@angle2 = (p2 - center).angle
			if @angle2 > @angle1 != @sweep_positive
				@angle2 += (@sweep_positive ? 1 : -1) * 2*Math::PI
			end
			@center = (center * @radius).rotate @rotation
		end
	end

	class CommandError < StandardError
	end

	class Command
		def initialize name, parameters, follow_up = name
			@name = name
			@parameters = parameters
			@follow_up = follow_up
		end

		def parse path, tokens
			relative = (?a..?z).include? tokens.shift
			name = @name.to_sym
			begin
				arguments = @parameters.map do |parameter|
					case parameter
					when :point
						point = Vector2D.new tokens.shift.to_f, tokens.shift.to_f
						point += path.current if relative
						point
					when :point_x
						x = tokens.shift.to_f
						Vector2D.new relative ? path.current.x + x : x, path.current.y
					when :point_y
						y = tokens.shift.to_f
						Vector2D.new path.current.x, relative ? path.current.y + y : y
					when :vector
						Vector2D.new tokens.shift.to_f, tokens.shift.to_f
					when :number
						tokens.shift.to_f
					when :boolean
						raise "Invalid boolean: #{tokens.first}" unless %w[0 1].include? tokens.first
						tokens.shift == ?1
					end
				end
				path.public_send name, *arguments
				name = @follow_up.to_sym
			end until tokens.empty? || tokens.first =~ /[a-zA-Z]/
		end
	end

	class Path
		COMMANDS = {
			m: Command.new(:move_to, %i[point], :line_to),
			l: Command.new(:line_to, %i[point]),
			h: Command.new(:line_to, %i[point_x]),
			v: Command.new(:line_to, %i[point_y]),
			z: Command.new(:close, %i[], :unexpected_token),
			c: Command.new(:cubic, %i[point point point]),
			s: Command.new(:smooth_cubic, %i[point point]),
			q: Command.new(:quadratic, %i[point point]),
			t: Command.new(:smooth_quadratic, %i[point]),
			a: Command.new(:arc, %i[vector number boolean boolean point]),
		}

		attr_reader :current

		def initialize data
			@segments = []
			@lengths = [0.0]
			@last_initial = 0
			@current = Vector2D.new 0.0, 0.0
			data.gsub! /[a-df-zA-DF-Z]/, ' \0 ' # exclude E for scientific notation
			data.gsub! /[,\s]+/, ' '
			data.strip!
			parse_instructions data.split
		end

		def unexpected_token
			raise CommandError.new 'Unexpected token'
		end

		def move_to point
			@last_initial = @segments.length
			@current = point
		end

		def line_to point
			add_segment Line.new @current, point
		end

		def close
			point = @segments[@last_initial].begin
			@current == point ? point : line_to(point)
		end

		def cubic control1, control2, point
			add_segment CubicBezier.new @current, control1, control2, point
		end

		def smooth_cubic control2, point
			last = @segments.last
			control1 = last.is_a?(CubicBezier) ? @current*2 - last.control2 : @current
			cubic control1, control2, point
		end

		def quadratic control, point
			add_segment QuadraticBezier.new @current, control, point
		end

		def smooth_quadratic point
			last = @segments.last
			control = last.is_a?(QuadraticBezier) ? @current*2 - last.control : @current
			quadratic control, point
		end

		def arc radius, rotation, large_arc, sweep_positive, point
			add_segment Arc.new @current, radius, rotation*Math::PI/180, large_arc, sweep_positive, point
		end

		def add_segment segment
			@segments.push segment
			@lengths.push @lengths.last + segment.length
			@current = segment.end
		end

		def length
			@lengths.last
		end

		def at_length s
			len = length
			s %= len*2
			s = 2*len - s if s > len
			i = @lengths.bsearch_index { _1 > s } - 1
			@segments[i].at_length s - @lengths[i]
		end

		def samples range, total = range.is_a?(Range) ? range.end : range
			return to_enum __method__, range, total unless block_given?
			range = 0...range unless range.is_a? Range
			len = length
			delta = len / total.to_f
			s = range.begin * delta
			sign = 1
			s %= len*2
			if s > len
				s = 2*len - s
				sign *= -1
			end
			i = @lengths.bsearch_index { _1 > s } - 1
			range.each do |j|
				if j == range.begin
					yield *@segments[i].at_length(s - @lengths[i]).to_a, j
					next
				end
				s += delta*sign
				s %= len*2
				if s > len
					s = 2*len - s
					sign *= -1
				end
				i -= 1 while i > 0 && s < @lengths[i]
				i += 1 while i < @lengths.length - 1 && s > @lengths[i+1]
				yield *@segments[i].at_length(s - @lengths[i]).to_a, j
			end
			self
		end

		private def parse_instructions tokens
			while instruction = tokens.first
				command = COMMANDS[instruction.downcase.to_sym]
				raise CommandError.new "Unknown command #{instruction}" unless command
				command.parse self, tokens
			end
		end
	end
end

module Sunniesnow::Tools
	module_function def path data, *args, &block
		result = SvgPath::Path.new data
		result.samples *args, &block if block
		result
	end
end
