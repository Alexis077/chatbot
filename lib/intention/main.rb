module Intention
  class Main
    INTENTIONS = {"1" => DepositInquiry::Create } 
    
    def initialize(intention)
      @intention = intention
    end

    def execute!
      select_intention
      return I18n.t('intention.errors.not_valid_option') if @selected_intention.nil?
    end

    private

    def select_intention
      @selected_intention = INTENTIONS[@intention]
    end
  end
end