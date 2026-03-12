# frozen_string_literal: true

class Sunniesnow::Charter

	# @note Internal API.
	# @!parse
	#   class GroupState < Data
	#     # @return [Array<Symbol>]
	#     attr_reader :tip_point_mode_stack
	#     # @return [Array<Integer?>]
	#     attr_reader :current_tip_point_stack
	#     # @return [Array<Array<Event>>]
	#     attr_reader :current_tip_point_group_stack
	#     # @return [Integer]
	#     attr_reader :current_duplicate
	#     # @return [Array<TipPointStart?>]
	#     attr_reader :tip_point_start_stack
	#     # @return [Array<TipPointStart?>]
	#     attr_reader :tip_point_start_to_add_stack
	#     # @return [Array<Array<Event>>]
	#     attr_reader :groups
	#   end
	GroupState = Data.define(
		:tip_point_mode_stack, :current_tip_point_stack,
		:current_tip_point_group_stack, :current_duplicate,
		:tip_point_start_stack, :tip_point_start_to_add_stack, :groups
	)

	# @note Internal API.
	# @!parse
	#   class Bookmark < Data
	#     # @return [BeatState]
	#     attr_reader :beat_state
	#     # @return [GroupState]
	#     attr_reader :group_state
	#   end
	Bookmark = Data.define :beat_state, :group_state

	# @note Internal API.
	# @return [void]
	def init_bookmarks
		@bookmarks = {}
		nil
	end

	# @note Internal API.
	# @return [void]
	def init_group_state
		@tip_point_mode_stack = [:none]
		@current_tip_point_stack = []
		@current_tip_point_group_stack = []
		@tip_point_peak = 0
		@current_duplicate = 0
		@tip_point_start_stack = [nil]
		@tip_point_start_to_add_stack = [nil]
		@groups = [@events]
		nil
	end

	# @note Internal API.
	# @return [GroupState]
	def current_group_state
		GroupState.new(
			@tip_point_mode_stack.dup,
			@current_tip_point_stack.dup,
			@current_tip_point_group_stack.dup,
			@current_duplicate,
			@tip_point_start_stack.dup,
			@tip_point_start_to_add_stack.dup,
			@groups.dup
		)
	end

	# @note Internal API.
	# @param backup [GroupState]
	# @return [void]
	def restore_group_state backup
		@tip_point_mode_stack = backup.tip_point_mode_stack
		@current_tip_point_stack = backup.current_tip_point_stack
		@current_tip_point_group_stack = backup.current_tip_point_group_stack
		@current_duplicate = backup.current_duplicate
		@tip_point_start_to_add_stack = backup.tip_point_start_to_add_stack
		@groups = backup.groups
		nil
	end

	# @!group DSL Methods

	# @return [Array<Event>] the events created inside +block+.
	# @yieldself [Charter] the same as +self+.
	def group preserve_beat: true, &block
		raise ArgumentError, 'no block given' unless block
		@groups.push result = []
		beat_backup = current_beat_state unless preserve_beat
		instance_eval &block
		restore_beat_state beat_backup unless preserve_beat
		@groups.delete_if { result.equal? _1 }
		result
	end

	# @param name [Object]
	# @return [Object] +name+.
	def mark name
		@bookmarks[name] = Bookmark.new current_beat_state, current_group_state
		name
	end

	# @return [Array<Event>]
	# @yieldself [Charter] the same as +self+.
	# @param name [Object] the name of the bookmark to jump to.
	# @param goto_beat [Boolean]
	# @param preserve_beat [Boolean]
	# @param update_mark [Boolean]
	def at name, goto_beat: true, preserve_beat: false, update_mark: false, &block
		raise ArgumentError, 'no block given' unless block
		raise ArgumentError, "unknown bookmark #{name}" unless bookmark = @bookmarks[name]
		group_backup = current_group_state
		beat_backup = current_beat_state unless preserve_beat
		restore_group_state bookmark.group_state
		restore_beat_state bookmark.beat_state if goto_beat
		result = group &block
		mark name if update_mark
		restore_group_state group_backup
		restore_beat_state beat_backup unless preserve_beat
		result
	end

	# @!endgroup

end
