def return_number(a)
  ((a / 2)**2) * (65 - (a / 2))
end

def your_childs_retirement_fund(your_age)
  childs_age = your_age / 2
  childs_bank_account = childs_age ** 2
  childs_wait_time = 65 - childs_age
  childs_bank_account * childs_wait_time
end

puts true if return_number(80) == your_childs_retirement(80)
