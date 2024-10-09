module PlatformProductMachine
  class StateMachine
    include Statesman::Machine
  
    state :initialized, initial: true
    state :locating
    state :located
    state :approved
    state :error
  
    transition from: :initialized, to: :locating
    transition from: :locating, to: [:located, :error]
    transition from: :located, to: :approved
  end
end