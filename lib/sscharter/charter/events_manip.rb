# frozen_string_literal: true

class Sunniesnow::Charter

	# Implements homography.
	class Transform
		include Math

		# @return [Float]
		attr_reader :xx, :xy, :xz, :yx, :yy, :yz, :zx, :zy, :zz

		# @return [Rational]
		attr_reader :tt, :t1

		def initialize
			@xx = @yy = @zz = 1.0
			@xy = @xz = @yx = @yz = @zx = @zy = 0.0
			@t1 = 0r
			@tt = 1r
		end

		# @param event [Event]
		# @return [Event] same as +event+.
		def apply event
			event.beat = @t1 + @tt * event.beat
			return unless x = event[:x]
			return unless y = event[:y]
			rx = xx*x + xy*y + xz
			ry = yx*x + yy*y + yz
			d = zx*x + zy*y + zz
			event[:x] = xp = rx / d
			event[:y] = yp = ry / d
			
			return event unless angle = event[:angle]
			dx = cos angle
			dy = sin angle
			cross = y*dx - x*dy

			cx0 = zy*xx - xy*zx
			cxx = zz*xx - xz*zx
			cxy = zz*xy - xz*zy
			dxp = cx0*cross + cxx*dx + cxy*dy

			cy0 = zx*yy - yx*zy
			cyy = zz*yy - yz*zy
			cyx = zz*yx - yz*zx
			dyp = cy0*-cross + cyy*dy + cyx*dx

			event[:angle] = atan2 dyp, dxp
			event
		end

		# @!group DSL Methods

		# @param xx [Numeric]
		# @param xy [Numeric]
		# @param yx [Numeric]
		# @param yy [Numeric]
		# @return [void]
		def compound_linear xx, xy, yx, yy
			raise ArgumentError, 'arguments must be numbers' unless [xx, xy, yx, yy].all? { _1.is_a? Numeric }
			@xx, @xy, @xz, @yx, @yy, @yz = [
				xx * @xx + xy * @yx,
				xx * @xy + xy * @yy,
				xx * @xz + xy * @yz,
				yx * @xx + yy * @yx,
				yx * @xy + yy * @yy,
				yx * @xz + yy * @yz,
			]
			nil
		end

		# @param dx [Numeric]
		# @param dy [Numeric]
		# @return [void]
		def translate dx, dy
			raise ArgumentError, 'dx and dy must be numbers' unless dx.is_a?(Numeric) && dy.is_a?(Numeric)
			@xz += dx
			@yz += dy
		end

		# @return [void]
		def horizontal_flip
			compound_linear -1, 0, 0, 1
		end

		# @return [void]
		def vertical_flip
			compound_linear 1, 0, 0, -1
		end

		# @param angle [Numeric] in radians.
		# @return [void]
		def rotate angle
			raise ArgumentError, 'angle must be a number' unless angle.is_a? Numeric
			warn 'Are you using degrees as angle unit instead of radians?' if angle != 0 && angle % 45 == 0
			c = cos angle
			s = sin angle
			compound_linear c, -s, s, c
		end

		# @param sx [Numeric]
		# @param sy [Numeric]
		# @return [void]
		def scale sx, sy = sx
			raise ArgumentError, 'sx and sy must be numbers' unless sx.is_a?(Numeric) && sy.is_a?(Numeric)
			compound_linear sx, 0, 0, sy
		end

		# @param delta_beat [Integer, Rational]
		# @return [void]
		def beat_translate delta_beat
			raise ArgumentError, 'delta_beat must be a number' unless delta_beat.is_a? Numeric
			warn 'Rational is recommended over Float for delta_beat' if delta_beat.is_a? Float
			@t1 += delta_beat.to_r
			nil
		end

		# @!endgroup
	end

	# @!group DSL Methods

	# Duplicate all events in a given array.
	# This method is useful when you want to duplicate a set of events.
	# The argument +events+ is an array of events to be duplicated.
	# The argument +new_tip_points+ is a boolean indicating whether to create new tip points.
	# If it is +true+, new tip points will be created for the duplicated events.
	# If it is +false+, each duplicated event shares the same tip point as the original event.
	# @param events [Array<Event>] the events to be duplicated.
	# @param new_tip_points [Boolean] whether to create new tip points for the duplicated events.
	# @return [Array<Event>] the duplicated events.
	# @example Duplicate a note
	#   offset 0.1; bpm 120
	#   duplicate [t 0, 0]
	# @example Duplicate notes that share tip points with the original notes
	#   offset 0.1; bpm 120
	#   duplicate tp_chain(0, 100, 1) { t 0, 0 }
	def duplicate events, new_tip_points: true
		result = []
		events.each do |event|
			next if event.type == :placeholder && !new_tip_points
			result.push event = event.dup
			if event[:tip_point] && new_tip_points
				event[:tip_point] = "#@current_duplicate #{event[:tip_point]}"
			end
			@groups.each { _1.push event }
		end
		@current_duplicate += 1 if new_tip_points
		result
	end

	# Transform all events in a given array in time and/or space.
	# Space transformation does not affect background patterns.
	# @yieldself [Transform]
	# @param events [Array<Event>, Event]
	# @return [Array<Event>]
	def transform events, &block
		raise ArgumentError, 'no block given' unless block
		events = [events] if events.is_a? Event
		transform = Transform.new
		transform.instance_eval &block
		events.each { transform.apply _1 }
	end

	# Remove events from the chart.
	# @param events [Array<Event>]
	# @return [Array<Event>]
	def remove *events
		events.each { |event| @groups.each { _1.delete event } }
	end

	# @!endgroup

end
