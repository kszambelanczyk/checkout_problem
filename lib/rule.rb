# frozen_string_literal: true

class Rule

  def initialize(conditions, actions)
    @conditions = conditions
    @actions = actions
  end

  def call(basket)
    # if all conditions are met
    if @conditions.all? { |condition| condition.check(basket) }
      # do actions on basket
      @actions.each { |action| action.perform(basket) }
    end

    return basket
  end

end
