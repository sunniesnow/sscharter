# frozen_string_literal: true

class Sunniesnow::Charter

	def check(
		notes_in_bound: true,
		bg_notes_in_bound: true
	)
		out_of_bound_events = [] if notes_in_bound || bg_notes_in_bound
		@events.each do |event|
			if %i[tap hold drag flick].include?(event.type) && notes_in_bound || event.type == :bg_note && bg_notes_in_bound
				if event[:x] < -100-1e-10 || event[:x] > 100+1e-10 || event[:y] < -50-1e-10 || event[:y] > 50+1e-10
					out_of_bound_events.push event
				end
			end
		end
		if notes_in_bound || bg_notes_in_bound
			if out_of_bound_events.empty?
				puts "===== All notes are in bound ====="
			else
				puts "===== Out-of-bound notes ====="
				out_of_bound_events.each do |event|
					p event
					puts "at time #{event.time}"
					puts 'defined at:'
					puts event.backtrace
				end
			end
		end
	end

end
