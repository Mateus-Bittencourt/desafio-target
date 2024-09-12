class CalculatesBillingService
  def initialize(daily_billing = [])
    # Remover valores nulos e espaços em branco, e converter para float
    @daily_billing = daily_billing.compact.reject { |value| value.strip.empty? rescue false }.map(&:to_f)
    puts @daily_billing
  end

  def call
    {
      lowest_billing_amount: lowest_billing_amount,
      highest_billing_amount: highest_billing_amount,
      total_days_with_value_over_the_average: total_days_with_value_over_the_average
    }
  end

  private

  def lowest_billing_amount
    @daily_billing.min
  end

  def highest_billing_amount
    @daily_billing.max
  end

  def total_days_with_value_over_the_average
    return 0 if @daily_billing.empty? # Evitar divisão por zero se o array estiver vazio

    average = @daily_billing.sum / @daily_billing.size
    puts average
    @daily_billing.count { |value| value > average }
  end
end

# Testando a classe
daily_billing = ["10", "", "15", nil, "20", "", 10]
service = CalculatesBillingService.new(daily_billing).call
puts service
