class PlatformProduct < ApplicationRecord
  belongs_to :product
  belongs_to :platform

  has_many :candidates, dependent: :destroy
  has_many :transitions, dependent: :destroy, class_name: 'PlatformProductMachine::Transition', autosave: false
  has_many :platform_product_prices, dependent: :destroy

  include Statesman::Adapters::ActiveRecordQueries[
    transition_class: PlatformProductMachine::Transition,
    initial_state: :initialized,
    transition_name: :transitions
  ]

  def state_machine
    @state_machine ||= PlatformProductMachine::StateMachine.new(
      self,
      transition_class: PlatformProductMachine::Transition,
      association_name: :transitions
    )
  end

  delegate :can_transition_to?,
           :current_state, :history, :last_transition, :last_transition_to,
           :transition_to!, :transition_to, :in_state?, to: :state_machine

end
