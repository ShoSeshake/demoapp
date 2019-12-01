class Location < ActiveHash::Base
  self.data = [
      {id:1 , name: '0 ~ ¥ 999'},{id:2 , name: '¥ 1,000 ~ ¥ 1,999'},{id:3 , name: '¥ 2,000 ~ ¥ 2,999'},{id:4 , name: '¥ 3,000 ~ ¥ 3,999'},
      {id:5 , name: '¥ 4,000 ~ ¥ 4,999'},{id:6 , name: '¥ 5,000 ~ ¥ 6,999'},{id:7 , name: '¥ 7,000 ~ ¥ 9,999'},{id:8 , name: '¥ 10,000 ~ '}
  ]
end