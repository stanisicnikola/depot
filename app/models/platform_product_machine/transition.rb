module PlatformProductMachine
  class Transition < ApplicationRecord
    self.table_name = "platform_product_transitions"

    include Statesman::Adapters::ActiveRecordTransition

    validates :to_state, inclusion: { in: PlatformProductMachine::StateMachine.states }
  
    belongs_to :platform_product, inverse_of: :transitions

    private

    def update_most_recent
      last_transition = platform_product.transitions.order(:sort_key).last
      return unless last_transition.present?

      last_transition.update_column(:most_recent, true)
    end
  end
end