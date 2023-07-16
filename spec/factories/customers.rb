FactoryBot.define do
  factory :customer do
    name { FFaker::Name.first_name }
    last_name { FFaker::Name.last_name }
    rut { generate_valid_chilean_rut }
    association :account, factory: :account
  end
end
def generate_valid_chilean_rut
  rut_digits = Array.new(8) { rand(1..9) } + [0]
  dv = calculate_dv(rut_digits.join.to_i)
  "#{rut_digits[0..1].join}.#{rut_digits[2..4].join}.#{rut_digits[5..7].join}-#{dv}"
end

def calculate_dv(rut_number)
  dv = 11 - (rut_number % 11)
  dv == 11 ? '0' : dv == 10 ? 'K' : dv.to_s
end