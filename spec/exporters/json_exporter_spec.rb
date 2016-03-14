require 'rails_helper'

describe JSONExporter do
	
	let(:exporter) {JSONExporter.new}

	let(:current_user_json){
		
		%Q({
			"_id":"56df40ad93a9a845256d306a",
			"provider":"local",
			"name":"liliane caetano",
			"email":"lnacif@avenuecode.com",
			"password":"test123",
			"__v":0,
			"role":"user"
		})
	}

	let(:not_so_friendly_json){
		%Q([{"_id":"56ab7fc22e481306042c151d","user":{"_id":"56ab7ee72e481306042c1518","name":"QA Couse User 1","email":"qacourseuser1@avenuecode.com"}},{"_id":"56ab7fd22e481306042c151e","user":{"_id":"56ab7ef12e481306042c1519","name":"QA Couse User 2","email":"qacourseuser2@avenuecode.com"}},{"_id":"56ab7fd82e481306042c151f","user":{"_id":"56ab7efb2e481306042c151a","name":"QA Couse User 3","email":"qacourseuser3@avenuecode.com"}},{"_id":"56ab7fe22e481306042c1520","user":{"_id":"56ab7f042e481306042c151b","name":"QA Couse User 4","email":"qacourseuser4@avenuecode.com"}},{"_id":"56ab7fec2e481306042c1521","user":{"_id":"56ab7f102e481306042c151c","name":"QA Couse User 5","email":"qacourseuser5@avenuecode.com"}}])
	}

	let(:super_friendly_json){
		friends_array = []
		16.times do 
			friends_array << %Q("_id":"56ab7fc22e481306042c151d","user":{"_id":"56ab7ee72e481306042c1518","name":"QA Couse User 1","email":"qacourseuser1@avenuecode.com"})
		end
		friends_array.join(",")
	JSON.parse("[#{friends_array}]")
	}

	let(:friendly_json) {
			friends_array = []
		10.times do 
			friends_array << %Q("_id":"56ab7fc22e481306042c151d","user":{"_id":"56ab7ee72e481306042c1518","name":"QA Couse User 1","email":"qacourseuser1@avenuecode.com"})
		end
		friends_array.join(",")

			JSON.parse("[#{friends_array}]")

	}


	context "should export my friends in JSON format" do
		it "should say my social type is SUPER_FRIENDLY" do
			json_exported = exporter.export_friends(super_friendly_json,current_user_json)
			json_exported = json_exported
			expect(json_exported["user"]["socialType"]).to eq("Super Friendly")
		end

		it "should say my social type is NOT_SO_FRIENDLY" do
			json_exported  = exporter.export_friends(not_so_friendly_json,current_user_json)
			json_exported = json_exported
			expect(json_exported ["user"]["socialType"]).to eq("Not So Friendly")
		end

			it "should say my social type is FRIENDLY" do
			json_exported  = exporter.export_friends(friendly_json,current_user_json)
			json_exported  = json_exported
			expect(json_exported["user"]["socialType"]).to eq("friendly")
		end

	it "should show 100% percentage attribute when i have more than 15 friends" do

			json_exported = exporter.export_friends(super_friendly_json,current_user_json)
			json_exported = json_exported
			expect(json_exported["user"]["socialPercentage"]).to eq("100%")
	end

	it "should show 66% percentage attribute when i have 10 friends" do

			json_exported = exporter.export_friends(not_so_friendly_json,current_user_json)
			json_exported = json_exported
			expect(json_exported["user"]["socialPercentage"]).to eq("66%")

	end
	end

end