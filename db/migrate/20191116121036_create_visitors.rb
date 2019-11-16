class CreateVisitors < ActiveRecord::Migration[5.2]
  def change
    # city: "Ho Chi Minh"
    # connection_type: ""
    # continent_code: "AS"
    # continent_name: "Asia"
    # country_capital: "Hanoi"
    # country_code2: "VN"
    # country_code3: "VNM"
    # country_flag: "https://ipgeolocation.io/static/flags/vn_64.png"
    # country_name: "Vietnam"
    # country_tld: ".vn"
    # currency: {code: "VND", name: "Vietnamese Dong", symbol: "₫"}
    # district: "Quan Tan Binh"
    # geoname_id: "1566083"
    # ip: "2001:ee0:50c4:c920:9d66:8c94:cab0:90c4"
    # is_eu: false
    # isp: "VNPT"
    # languages: "vi,en,fr,zh,km"
    # latitude: "10.82310"
    # longitude: "106.63000"
    # organization: ""
    # state_prov: "Ho Chi Minh"
    # time_zone: {name: "Asia/Ho_Chi_Minh", offset: 7, current_time: "2019-11-16 19:05:43.245+0700", current_time_unix: 1573905943.245, is_dst: false, …}
    # zipcode: "76000"
    create_table :visitors do |t|

      t.string :city, limit: 40
      t.string :continent_code, limit: 10
      t.string :continent_name, limit: 30 #: "Asia"
      t.string :country_capital, limit: 30 # "Hanoi"
      t.string :country_code2, limit: 10 #: "VN"
      t.string :country_code3, limit: 10 #: "VNM"
      # country_flag: "https://ipgeolocation.io/static/flags/vn_64.png"
      t.string :country_name #: "Vietnam"
      t.string :country_tld, limit: 10 #: ".vn"
      t.string :currency # {code: "VND", name: "Vietnamese Dong", symbol: "₫"}
      t.string :district, limit: 30 # "Quan Tan Binh"
      t.string :geoname_id, limit: 10 # : "1566083"
      t.string :ip, limit: 40 # "2001:ee0:50c4:c920:9d66:8c94:cab0:90c4"
      t.boolean :is_eu #: false
      t.string :isp, limit: 20 # "VNPT"
      # languages: "vi,en,fr,zh,km"
      t.string :latitude, limit: 10 # "10.82310"
      t.string :longitude, limit: 10 # "106.63000"
      # organization: ""
      t.string :state_prov, limit: 30 # "Ho Chi Minh"
      t.string :time_zone #: {name: "Asia/Ho_Chi_Minh", offset: 7, current_time: "2019-11-16 19:05:43.245+0700", current_time_unix: 1573905943.245, is_dst: false, …}
      t.string :zipcode, limit: 10 # "76000"
      t.timestamps null: false

    end
  end
end
