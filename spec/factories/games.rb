FactoryGirl.define do
  factory :game do
    statisitcs =  {1=> {1=>"", 2=> "", 3=> ""},
                   2=> {1=>"", 2=> "", 3=> ""},
                   3=> {1=>"", 2=> "", 3=> ""}
                  }
    turn = nil
    winner = nil
    status = 0
  end
end
