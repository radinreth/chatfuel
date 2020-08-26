namespace :simulate_data do
  desc "Simulate data via HTTP request like Chatfuel using json_api & Verboice using external service"
  task via_http_request: :environment do
    headers = { content_type: :json, accept: :json }
    route = "0.0.0.0:3000/bots/sessions/chatbot"

    people = {
      # User access owso_info
      "4055784944491573": [
        { messenger_user_id: "4055784944491573", name: "gender", value: "f" },
        { messenger_user_id: "4055784944491573", name: "location", value: "0206" },
        { messenger_user_id: "4055784944491573", name: "main_menu", value: "owso_info" },
        { messenger_user_id: "4055784944491573", name: "owso_info", value: "certify_docs" },
        { messenger_user_id: "4055784944491573", name: "certify_docs", value: "certify_docs_1" }
      ],
      "3130621300351574": [
        { messenger_user_id: "3130621300351574", name: "gender", value: "f" },
        { messenger_user_id: "3130621300351574", name: "location", value: "0206" },
        { messenger_user_id: "3130621300351574", name: "main_menu", value: "owso_info" },
        { messenger_user_id: "3130621300351574", name: "owso_info", value: "certify_docs" },
        { messenger_user_id: "3130621300351574", name: "certify_docs", value: "certify_docs_2" }
      ],

      "4178164752256231": [
        { messenger_user_id: "4178164752256231", name: "gender", value: "f" },
        { messenger_user_id: "4178164752256231", name: "location", value: "0212" },
        { messenger_user_id: "4178164752256231", name: "main_menu", value: "owso_info" },
        { messenger_user_id: "4178164752256231", name: "owso_info", value: "main_dbs" },
        { messenger_user_id: "4178164752256231", name: "main_dbs", value: "dbs_btn1" }
      ],
      "3412716758746938": [
        { messenger_user_id: "3412716758746938", name: "gender", value: "f" },
        { messenger_user_id: "3412716758746938", name: "location", value: "0212" },
        { messenger_user_id: "3412716758746938", name: "main_menu", value: "owso_info" },
        { messenger_user_id: "3412716758746938", name: "owso_info", value: "main_dbs" },
        { messenger_user_id: "3412716758746938", name: "main_dbs", value: "dbs_btn1" }
      ],
      "3165459796901632": [
        { messenger_user_id: "3165459796901632", name: "gender", value: "m" },
        { messenger_user_id: "3165459796901632", name: "location", value: "0204" },
        { messenger_user_id: "3165459796901632", name: "main_menu", value: "owso_info" },
        { messenger_user_id: "3165459796901632", name: "owso_info", value: "main_dbs" },
        { messenger_user_id: "3165459796901632", name: "main_dbs", value: "dbs_btn1" },
        { messenger_user_id: "3165459796901632", name: "dbs_btn1", value: "dbs_btn1_1" }
      ],
      "3015307228581930": [
        { messenger_user_id: "3015307228581930", name: "gender", value: "f" },
        { messenger_user_id: "3015307228581930", name: "location", value: "0206" },
        { messenger_user_id: "3015307228581930", name: "main_menu", value: "owso_info" },
        { messenger_user_id: "3015307228581930", name: "owso_info", value: "main_dbs" },
        { messenger_user_id: "3015307228581930", name: "main_dbs", value: "dbs_btn1" },
        { messenger_user_id: "3015307228581930", name: "dbs_btn1", value: "dbs_btn1_2" }
      ],
      "3015307228581931": [
        { messenger_user_id: "3015307228581931", name: "gender", value: "f" },
        { messenger_user_id: "3015307228581931", name: "location", value: "0203" },
        { messenger_user_id: "3015307228581931", name: "main_menu", value: "owso_info" },
        { messenger_user_id: "3015307228581931", name: "owso_info", value: "main_dbs" },
        { messenger_user_id: "3015307228581931", name: "main_dbs", value: "dbs_btn1" },
        { messenger_user_id: "3015307228581931", name: "dbs_btn1", value: "dbs_btn1_3" }
      ],


      "4952771681415409": [
        { messenger_user_id: "4952771681415409", name: "gender", value: "m" },
        { messenger_user_id: "4952771681415409", name: "location", value: "0000" },
        { messenger_user_id: "4952771681415409", name: "main_menu", value: "owso_info" },
        { messenger_user_id: "4952771681415409", name: "owso_info", value: "main_dbs" },
        { messenger_user_id: "4952771681415409", name: "main_dbs", value: "dbs_btn2" },
        { messenger_user_id: "4952771681415409", name: "dbs_btn2", value: "dbs_btn2_1" }
      ],
      "3400688933341054": [
        { messenger_user_id: "3400688933341054", name: "gender", value: "m" },
        { messenger_user_id: "3400688933341054", name: "location", value: "0000" },
        { messenger_user_id: "3400688933341054", name: "main_menu", value: "owso_info" },
        { messenger_user_id: "3400688933341054", name: "owso_info", value: "main_dbs" },
        { messenger_user_id: "3400688933341054", name: "main_dbs", value: "dbs_btn2" },
        { messenger_user_id: "3400688933341054", name: "dbs_btn2", value: "dbs_btn2_3" }
      ],
      "3000399930077662": [
        { messenger_user_id: "3000399930077662", name: "gender", value: "m" },
        { messenger_user_id: "3000399930077662", name: "location", value: "0204" },
        { messenger_user_id: "3000399930077662", name: "main_menu", value: "owso_info" },
        { messenger_user_id: "3000399930077662", name: "owso_info", value: "main_dbs" },
        { messenger_user_id: "3000399930077662", name: "main_dbs", value: "dbs_btn2" },
        { messenger_user_id: "3000399930077662", name: "dbs_btn2", value: "dbs_btn2_4" }
      ],
      "3258467737601273": [
        { messenger_user_id: "3258467737601273", name: "gender", value: "f" },
        { messenger_user_id: "3258467737601273", name: "location", value: "0203" },
        { messenger_user_id: "3258467737601273", name: "main_menu", value: "owso_info" },
        { messenger_user_id: "3258467737601273", name: "owso_info", value: "main_dbs" },
        { messenger_user_id: "3258467737601273", name: "main_dbs", value: "dbs_btn2" },
        { messenger_user_id: "3258467737601273", name: "dbs_btn2", value: "dbs_btn22" },
        { messenger_user_id: "3258467737601273", name: "dbs_btn22", value: "dbs_btn2_2_1" }
      ],
      "3480802098620826": [
        { messenger_user_id: "3480802098620826", name: "gender", value: "f" },
        { messenger_user_id: "3480802098620826", name: "location", value: "0203" },
        { messenger_user_id: "3480802098620826", name: "main_menu", value: "owso_info" },
        { messenger_user_id: "3480802098620826", name: "owso_info", value: "main_dbs" },
        { messenger_user_id: "3480802098620826", name: "main_dbs", value: "dbs_btn2" },
        { messenger_user_id: "3480802098620826", name: "dbs_btn2", value: "dbs_btn22" },
        { messenger_user_id: "3480802098620826", name: "dbs_btn22", value: "dbs_btn2_2_2" }
      ],
      "2955621404561393": [
        { messenger_user_id: "2955621404561393", name: "gender", value: "m" },
        { messenger_user_id: "2955621404561393", name: "location", value: "0000" },
        { messenger_user_id: "2955621404561393", name: "main_menu", value: "owso_info" },
        { messenger_user_id: "2955621404561393", name: "owso_info", value: "main_construction" },
        { messenger_user_id: "2955621404561393", name: "main_construction", value: "construction_1" },
        { messenger_user_id: "2955621404561393", name: "construction_1", value: "construction_1_1" }
      ],
      "3135278626509159": [
        { messenger_user_id: "3135278626509159", name: "gender", value: "m" },
        { messenger_user_id: "3135278626509159", name: "location", value: "0000" },
        { messenger_user_id: "3135278626509159", name: "main_menu", value: "owso_info" },
        { messenger_user_id: "3135278626509159", name: "owso_info", value: "main_construction" },
        { messenger_user_id: "3135278626509159", name: "main_construction", value: "construction_1" },
        { messenger_user_id: "3135278626509159", name: "construction_1", value: "construction_1_2" }
      ],
      "3226399517435560": [
        { messenger_user_id: "3226399517435560", name: "gender", value: "f" },
        { messenger_user_id: "3226399517435560", name: "location", value: "0202" },
        { messenger_user_id: "3226399517435560", name: "main_menu", value: "owso_info" },
        { messenger_user_id: "3226399517435560", name: "owso_info", value: "main_construction" },
        { messenger_user_id: "3226399517435560", name: "main_construction", value: "construction_1" },
        { messenger_user_id: "3226399517435560", name: "construction_1", value: "construction_1_3" }
      ],
      "3336822606375325": [
        { messenger_user_id: "3336822606375325", name: "gender", value: "f" },
        { messenger_user_id: "3336822606375325", name: "location", value: "0202" },
        { messenger_user_id: "3336822606375325", name: "main_menu", value: "owso_info" },
        { messenger_user_id: "3336822606375325", name: "owso_info", value: "main_construction" },
        { messenger_user_id: "3336822606375325", name: "main_construction", value: "construction_1" },
        { messenger_user_id: "3336822606375325", name: "construction_1", value: "construction_1_4" }
      ],
      "3152578874869482": [
        { messenger_user_id: "3152578874869482", name: "gender", value: "f" },
        { messenger_user_id: "3152578874869482", name: "location", value: "0206" },
        { messenger_user_id: "3152578874869482", name: "main_menu", value: "owso_info" },
        { messenger_user_id: "3152578874869482", name: "owso_info", value: "main_construction" },
        { messenger_user_id: "3152578874869482", name: "main_construction", value: "construction_1" },
        { messenger_user_id: "3152578874869482", name: "construction_1", value: "construction_1_5" }
      ],
      "4629929910352300": [
        { messenger_user_id: "4629929910352300", name: "gender", value: "f" },
        { messenger_user_id: "4629929910352300", name: "location", value: "0202" },
        { messenger_user_id: "4629929910352300", name: "main_menu", value: "owso_info" },
        { messenger_user_id: "4629929910352300", name: "owso_info", value: "main_construction" },
        { messenger_user_id: "4629929910352300", name: "main_construction", value: "construction_2" },
        { messenger_user_id: "4629929910352300", name: "construction_2", value: "construction_2_1" }
      ],
      "3201578793252614": [
        { messenger_user_id: "3201578793252614", name: "gender", value: "f" },
        { messenger_user_id: "3201578793252614", name: "location", value: "0212" },
        { messenger_user_id: "3201578793252614", name: "main_menu", value: "owso_info" },
        { messenger_user_id: "3201578793252614", name: "owso_info", value: "main_construction" },
        { messenger_user_id: "3201578793252614", name: "main_construction", value: "construction_2" },
        { messenger_user_id: "3201578793252614", name: "construction_2", value: "construction_2_2" }
      ],
      "4230655077009681": [
        { messenger_user_id: "4230655077009681", name: "gender", value: "f" },
        { messenger_user_id: "4230655077009681", name: "location", value: "0000" },
        { messenger_user_id: "4230655077009681", name: "main_menu", value: "owso_info" },
        { messenger_user_id: "4230655077009681", name: "owso_info", value: "main_construction" },
        { messenger_user_id: "4230655077009681", name: "main_construction", value: "construction_2" },
        { messenger_user_id: "4230655077009681", name: "construction_2", value: "construction_2_3" }
      ],
      "3654502641227988": [
        { messenger_user_id: "3654502641227988", name: "gender", value: "m" },
        { messenger_user_id: "3654502641227988", name: "location", value: "0212" },
        { messenger_user_id: "3654502641227988", name: "main_menu", value: "owso_info" },
        { messenger_user_id: "3654502641227988", name: "owso_info", value: "main_construction" },
        { messenger_user_id: "3654502641227988", name: "main_construction", value: "construction_2" },
        { messenger_user_id: "3654502641227988", name: "construction_2", value: "construction_2_4" }
      ],
      "4287752687961655": [
        { messenger_user_id: "4287752687961655", name: "gender", value: "m" },
        { messenger_user_id: "4287752687961655", name: "location", value: "0206" },
        { messenger_user_id: "4287752687961655", name: "main_menu", value: "owso_info" },
        { messenger_user_id: "4287752687961655", name: "owso_info", value: "main_construction" },
        { messenger_user_id: "4287752687961655", name: "main_construction", value: "construction_2" },
        { messenger_user_id: "4287752687961655", name: "construction_2", value: "construction_2_5" }
      ],
      "4170205696385695": [
        { messenger_user_id: "4170205696385695", name: "gender", value: "f" },
        { messenger_user_id: "4170205696385695", name: "location", value: "0204" },
        { messenger_user_id: "4170205696385695", name: "main_menu", value: "owso_info" },
        { messenger_user_id: "4170205696385695", name: "owso_info", value: "main_construction" },
        { messenger_user_id: "4170205696385695", name: "main_construction", value: "construction_3" },
        { messenger_user_id: "4170205696385695", name: "construction_3", value: "construction_3_1" }
      ],
      "4180833888625371": [
        { messenger_user_id: "4180833888625371", name: "gender", value: "m" },
        { messenger_user_id: "4180833888625371", name: "location", value: "0202" },
        { messenger_user_id: "4180833888625371", name: "main_menu", value: "owso_info" },
        { messenger_user_id: "4180833888625371", name: "owso_info", value: "main_construction" },
        { messenger_user_id: "4180833888625371", name: "main_construction", value: "construction_3" },
        { messenger_user_id: "4180833888625371", name: "construction_3", value: "construction_3_2" }
      ],
      "4338071799567081": [
        { messenger_user_id: "4338071799567081", name: "gender", value: "m" },
        { messenger_user_id: "4338071799567081", name: "location", value: "0000" },
        { messenger_user_id: "4338071799567081", name: "main_menu", value: "owso_info" },
        { messenger_user_id: "4338071799567081", name: "owso_info", value: "main_construction" },
        { messenger_user_id: "4338071799567081", name: "main_construction", value: "construction_3" },
        { messenger_user_id: "4338071799567081", name: "construction_3", value: "construction_3_3" }
      ],
      "3342485835818702": [
        { messenger_user_id: "3342485835818702", name: "gender", value: "f" },
        { messenger_user_id: "3342485835818702", name: "location", value: "0202" },
        { messenger_user_id: "3342485835818702", name: "main_menu", value: "owso_info" },
        { messenger_user_id: "3342485835818702", name: "owso_info", value: "main_construction" },
        { messenger_user_id: "3342485835818702", name: "main_construction", value: "construction_3" },
        { messenger_user_id: "3342485835818702", name: "construction_3", value: "construction_3_4" }
      ],
      "3255000631245237": [
        { messenger_user_id: "3255000631245237", name: "gender", value: "f" },
        { messenger_user_id: "3255000631245237", name: "location", value: "0206" },
        { messenger_user_id: "3255000631245237", name: "main_menu", value: "owso_info" },
        { messenger_user_id: "3255000631245237", name: "owso_info", value: "main_construction" },
        { messenger_user_id: "3255000631245237", name: "main_construction", value: "construction_3" },
        { messenger_user_id: "3255000631245237", name: "construction_3", value: "construction_3_5" }
      ],
      "4233493916725130": [
        { messenger_user_id: "4233493916725130", name: "gender", value: "f" },
        { messenger_user_id: "4233493916725130", name: "location", value: "0202" },
        { messenger_user_id: "4233493916725130", name: "main_menu", value: "owso_info" },
        { messenger_user_id: "4233493916725130", name: "owso_info", value: "main_landtitle" },
        { messenger_user_id: "4233493916725130", name: "main_landtitle", value: "landtitle_1" },
        { messenger_user_id: "4233493916725130", name: "landtitle_1", value: "landtitle_1_1" }
      ],
      "3782073135152856": [
        { messenger_user_id: "3782073135152856", name: "gender", value: "f" },
        { messenger_user_id: "3782073135152856", name: "location", value: "0212" },
        { messenger_user_id: "3782073135152856", name: "main_menu", value: "owso_info" },
        { messenger_user_id: "3782073135152856", name: "owso_info", value: "main_landtitle" },
        { messenger_user_id: "3782073135152856", name: "main_landtitle", value: "landtitle_1" },
        { messenger_user_id: "3782073135152856", name: "landtitle_1", value: "landtitle_1_2" }
      ],
      "2874198989351069": [
        { messenger_user_id: "2874198989351069", name: "gender", value: "f" },
        { messenger_user_id: "2874198989351069", name: "location", value: "0212" },
        { messenger_user_id: "2874198989351069", name: "main_menu", value: "owso_info" },
        { messenger_user_id: "2874198989351069", name: "owso_info", value: "main_landtitle" },
        { messenger_user_id: "2874198989351069", name: "main_landtitle", value: "landtitle_1" },
        { messenger_user_id: "2874198989351069", name: "landtitle_1", value: "landtitle_1_3" }
      ],
      "2663061130462149": [
        { messenger_user_id: "2663061130462149", name: "gender", value: "f" },
        { messenger_user_id: "2663061130462149", name: "location", value: "0206" },
        { messenger_user_id: "2663061130462149", name: "main_menu", value: "owso_info" },
        { messenger_user_id: "2663061130462149", name: "owso_info", value: "main_landtitle" },
        { messenger_user_id: "2663061130462149", name: "main_landtitle", value: "landtitle_1" },
        { messenger_user_id: "2663061130462149", name: "landtitle_1", value: "landtitle_1_4" }
      ],
      "3153690364712413": [
        { messenger_user_id: "3153690364712413", name: "gender", value: "f" },
        { messenger_user_id: "3153690364712413", name: "location", value: "0212" },
        { messenger_user_id: "3153690364712413", name: "main_menu", value: "owso_info" },
        { messenger_user_id: "3153690364712413", name: "owso_info", value: "main_landtitle" },
        { messenger_user_id: "3153690364712413", name: "main_landtitle", value: "landtitle_1" },
        { messenger_user_id: "3153690364712413", name: "landtitle_1", value: "landtitle_1_5" }
      ],
      "3415736891810389": [
        { messenger_user_id: "3415736891810389", name: "gender", value: "m" },
        { messenger_user_id: "3415736891810389", name: "location", value: "0202" },
        { messenger_user_id: "3415736891810389", name: "main_menu", value: "owso_info" },
        { messenger_user_id: "3415736891810389", name: "owso_info", value: "main_landtitle" },
        { messenger_user_id: "3415736891810389", name: "main_landtitle", value: "landtitle_1" },
        { messenger_user_id: "3415736891810389", name: "landtitle_1", value: "landtitle_1_6" }
      ],
      "4041914925883999": [
        { messenger_user_id: "4041914925883999", name: "gender", value: "f" },
        { messenger_user_id: "4041914925883999", name: "location", value: "0206" },
        { messenger_user_id: "4041914925883999", name: "main_menu", value: "owso_info" },
        { messenger_user_id: "4041914925883999", name: "owso_info", value: "main_landtitle" },
        { messenger_user_id: "4041914925883999", name: "main_landtitle", value: "landtitle_1" },
        { messenger_user_id: "4041914925883999", name: "landtitle_1", value: "landtitle_1_7" }
      ],
      "3184352338347189": [
        { messenger_user_id: "3184352338347189", name: "gender", value: "m" },
        { messenger_user_id: "3184352338347189", name: "location", value: "0206" },
        { messenger_user_id: "3184352338347189", name: "main_menu", value: "feedback" },
        { messenger_user_id: "3184352338347189", name: "feedback_unit", value: "battambang" },
        { messenger_user_id: "3184352338347189", name: "feedback_rating", value: "1" },
        { messenger_user_id: "3184352338347189", name: "feedback_challenge", value: "high price" },
        { messenger_user_id: "3184352338347189", name: "feedback_like", value: "working hour" },
        { messenger_user_id: "3184352338347189", name: "feedback_dislike", value: "speech" }
      ],
      "4492970497387280": [
        { messenger_user_id: "4492970497387280", name: "gender", value: "m" },
        { messenger_user_id: "4492970497387280", name: "location", value: "0204" },
        { messenger_user_id: "4492970497387280", name: "main_menu", value: "feedback" },
        { messenger_user_id: "4492970497387280", name: "feedback_unit", value: "feedback_district" },
        { messenger_user_id: "4492970497387280", name: "feedback_district", value: "mong russei" },
        { messenger_user_id: "4492970497387280", name: "feedback_rating", value: "3" },
        { messenger_user_id: "4492970497387280", name: "feedback_challenge", value: "take long time" },
        { messenger_user_id: "4492970497387280", name: "feedback_like", value: "pricing" },
        { messenger_user_id: "4492970497387280", name: "feedback_dislike", value: "request form" }
      ],
      "3252163604844051": [
        { messenger_user_id: "3252163604844051", name: "gender", value: "m" },
        { messenger_user_id: "3252163604844051", name: "location", value: "0000" },
        { messenger_user_id: "3252163604844051", name: "main_menu", value: "feedback" },
        { messenger_user_id: "3252163604844051", name: "feedback_unit", value: "feedback_district" },
        { messenger_user_id: "3252163604844051", name: "feedback_district", value: "mong russei" },
        { messenger_user_id: "3252163604844051", name: "feedback_rating", value: "5" },
        { messenger_user_id: "3252163604844051", name: "feedback_challenge", value: "take long time" },
        { messenger_user_id: "3252163604844051", name: "feedback_like", value: "pricing" },
        { messenger_user_id: "3252163604844051", name: "feedback_dislike", value: "request form" }
      ],
      "3192641317523703": [
        { messenger_user_id: "3192641317523703", name: "gender", value: "f" },
        { messenger_user_id: "3192641317523703", name: "location", value: "0000" },
        { messenger_user_id: "3192641317523703", name: "main_menu", value: "feedback" },
        { messenger_user_id: "3192641317523703", name: "feedback_unit", value: "feedback_district" },
        { messenger_user_id: "3192641317523703", name: "feedback_district", value: "mong russei" },
        { messenger_user_id: "3192641317523703", name: "feedback_rating", value: "4" },
        { messenger_user_id: "3192641317523703", name: "feedback_challenge", value: "take long time" },
        { messenger_user_id: "3192641317523703", name: "feedback_like", value: "pricing" },
        { messenger_user_id: "3192641317523703", name: "feedback_dislike", value: "request form" }
      ],
      "3443721415685513": [
        { messenger_user_id: "3443721415685513", name: "gender", value: "f" },
        { messenger_user_id: "3443721415685513", name: "location", value: "0204" },
        { messenger_user_id: "3443721415685513", name: "main_menu", value: "feedback" },
        { messenger_user_id: "3443721415685513", name: "feedback_unit", value: "feedback_district" },
        { messenger_user_id: "3443721415685513", name: "feedback_district", value: "mong russei" },
        { messenger_user_id: "3443721415685513", name: "feedback_rating", value: "2" },
        { messenger_user_id: "3443721415685513", name: "feedback_challenge", value: "take long time" },
        { messenger_user_id: "3443721415685513", name: "feedback_like", value: "pricing" },
        { messenger_user_id: "3443721415685513", name: "feedback_dislike", value: "request form" }
      ],
      "3245666842135192": [
        { messenger_user_id: "3245666842135192", name: "gender", value: "m" },
        { messenger_user_id: "3245666842135192", name: "location", value: "0000" },
        { messenger_user_id: "3245666842135192", name: "main_menu", value: "feedback" },
        { messenger_user_id: "3245666842135192", name: "feedback_unit", value: "feedback_district" },
        { messenger_user_id: "3245666842135192", name: "feedback_district", value: "mong russei" },
        { messenger_user_id: "3245666842135192", name: "feedback_rating", value: "3" },
        { messenger_user_id: "3245666842135192", name: "feedback_challenge", value: "take long time" },
        { messenger_user_id: "3245666842135192", name: "feedback_like", value: "pricing" },
        { messenger_user_id: "3245666842135192", name: "feedback_dislike", value: "request form" }
      ],
      "3245356632210297": [
        { messenger_user_id: "3245356632210297", name: "gender", value: "m" },
        { messenger_user_id: "3245356632210297", name: "location", value: "0202" },
        { messenger_user_id: "3245356632210297", name: "main_menu", value: "feedback" },
        { messenger_user_id: "3245356632210297", name: "feedback_unit", value: "feedback_district" },
        { messenger_user_id: "3245356632210297", name: "feedback_district", value: "mong russei" },
        { messenger_user_id: "3245356632210297", name: "feedback_rating", value: "4" },
        { messenger_user_id: "3245356632210297", name: "feedback_challenge", value: "take long time" },
        { messenger_user_id: "3245356632210297", name: "feedback_like", value: "pricing" },
        { messenger_user_id: "3245356632210297", name: "feedback_dislike", value: "request form" }
      ],
      "3831831780167354": [
        { messenger_user_id: "3831831780167354", name: "gender", value: "f" },
        { messenger_user_id: "3831831780167354", name: "location", value: "0203" },
        { messenger_user_id: "3831831780167354", name: "main_menu", value: "feedback" },
        { messenger_user_id: "3831831780167354", name: "feedback_unit", value: "feedback_district" },
        { messenger_user_id: "3831831780167354", name: "feedback_district", value: "mong russei" },
        { messenger_user_id: "3831831780167354", name: "feedback_rating", value: "5" },
        { messenger_user_id: "3831831780167354", name: "feedback_challenge", value: "take long time" },
        { messenger_user_id: "3831831780167354", name: "feedback_like", value: "pricing" },
        { messenger_user_id: "3831831780167354", name: "feedback_dislike", value: "request form" }
      ],
      "4185198781554788": [
        { messenger_user_id: "4185198781554788", name: "gender", value: "m" },
        { messenger_user_id: "4185198781554788", name: "location", value: "0212" },
        { messenger_user_id: "4185198781554788", name: "main_menu", value: "feedback" },
        { messenger_user_id: "4185198781554788", name: "feedback_unit", value: "feedback_district" },
        { messenger_user_id: "4185198781554788", name: "feedback_district", value: "mong russei" },
        { messenger_user_id: "4185198781554788", name: "feedback_rating", value: "4" },
        { messenger_user_id: "4185198781554788", name: "feedback_challenge", value: "take long time" },
        { messenger_user_id: "4185198781554788", name: "feedback_like", value: "pricing" },
        { messenger_user_id: "4185198781554788", name: "feedback_dislike", value: "request form" }
      ],
      "3154945291227644": [
        { messenger_user_id: "3154945291227644", name: "gender", value: "f" },
        { messenger_user_id: "3154945291227644", name: "location", value: "0212" },
        { messenger_user_id: "3154945291227644", name: "main_menu", value: "tracking" },
        { messenger_user_id: "3154945291227644", name: "ticket_code", value: "1223894334" }
      ],
      "3471402996217734": [
        { messenger_user_id: "3471402996217734", name: "gender", value: "f" },
        { messenger_user_id: "3471402996217734", name: "location", value: "0206" },
        { messenger_user_id: "3471402996217734", name: "main_menu", value: "tracking" },
        { messenger_user_id: "3471402996217734", name: "ticket_code", value: "1238459434" }
      ],
      "3156667731088013": [
        { messenger_user_id: "3156667731088013", name: "gender", value: "f" },
        { messenger_user_id: "3156667731088013", name: "location", value: "0203" },
        { messenger_user_id: "3156667731088013", name: "main_menu", value: "tracking" },
        { messenger_user_id: "3156667731088013", name: "ticket_code", value: "1203423234" }
      ],
      "3918844021475900": [
        { messenger_user_id: "3918844021475900", name: "gender", value: "m" },
        { messenger_user_id: "3918844021475900", name: "location", value: "0203" },
        { messenger_user_id: "3918844021475900", name: "main_menu", value: "tracking" },
        { messenger_user_id: "3918844021475900", name: "ticket_code", value: "1230492334" }
      ],
      "4181069525298843": [
        { messenger_user_id: "4181069525298843", name: "gender", value: "m" },
        { messenger_user_id: "4181069525298843", name: "location", value: "0204" },
        { messenger_user_id: "4181069525298843", name: "main_menu", value: "tracking" },
        { messenger_user_id: "4181069525298843", name: "ticket_code", value: "122397492334" }
      ],
      "3422429487777774": [
        { messenger_user_id: "3422429487777774", name: "gender", value: "f" },
        { messenger_user_id: "3422429487777774", name: "location", value: "0202" },
        { messenger_user_id: "3422429487777774", name: "main_menu", value: "tracking" },
        { messenger_user_id: "3422429487777774", name: "ticket_code", value: "12234923434" }
      ],
      "3124056997709874": [
        { messenger_user_id: "3124056997709874", name: "gender", value: "f" },
        { messenger_user_id: "3124056997709874", name: "location", value: "0000" },
        { messenger_user_id: "3124056997709874", name: "main_menu", value: "tracking" },
        { messenger_user_id: "3124056997709874", name: "ticket_code", value: "123w8948544" }
      ],
      "3438416749536620": [
        { messenger_user_id: "3438416749536620", name: "gender", value: "f" },
        { messenger_user_id: "3438416749536620", name: "location", value: "0204" },
        { messenger_user_id: "3438416749536620", name: "main_menu", value: "tracking" },
        { messenger_user_id: "3438416749536620", name: "ticket_code", value: "123742334" }
      ],
      "2990701274388584": [
        { messenger_user_id: "2990701274388584", name: "gender", value: "m" },
        { messenger_user_id: "2990701274388584", name: "location", value: "0202" },
        { messenger_user_id: "2990701274388584", name: "main_menu", value: "tracking" },
        { messenger_user_id: "2990701274388584", name: "ticket_code", value: "122394729334" }
      ],
      "4481858791839378": [
        { messenger_user_id: "4481858791839378", name: "gender", value: "f" },
        { messenger_user_id: "4481858791839378", name: "location", value: "0212" },
        { messenger_user_id: "4481858791839378", name: "main_menu", value: "tracking" },
        { messenger_user_id: "4481858791839378", name: "ticket_code", value: "1232315234" }
      ],
      "3173911022655997": [
        { messenger_user_id: "3173911022655997", name: "gender", value: "f" },
        { messenger_user_id: "3173911022655997", name: "location", value: "0000" },
        { messenger_user_id: "3173911022655997", name: "main_menu", value: "tracking" },
        { messenger_user_id: "3173911022655997", name: "ticket_code", value: "123878674" }
      ],
      "3348614328549380": [
        { messenger_user_id: "3348614328549380", name: "gender", value: "f" },
        { messenger_user_id: "3348614328549380", name: "location", value: "0204" },
        { messenger_user_id: "3348614328549380", name: "main_menu", value: "tracking" },
        { messenger_user_id: "3348614328549380", name: "ticket_code", value: "342342342" }
      ],
      "3051476141647665": [
        { messenger_user_id: "3051476141647665", name: "gender", value: "m" },
        { messenger_user_id: "3051476141647665", name: "location", value: "0212" },
        { messenger_user_id: "3051476141647665", name: "main_menu", value: "tracking" },
        { messenger_user_id: "3051476141647665", name: "ticket_code", value: "123234234" }
      ],
      "3215220565234269": [
        { messenger_user_id: "3215220565234269", name: "gender", value: "m" },
        { messenger_user_id: "3215220565234269", name: "location", value: "0206" },
        { messenger_user_id: "3215220565234269", name: "main_menu", value: "tracking" },
        { messenger_user_id: "3215220565234269", name: "ticket_code", value: "1234234" }
      ],

      # User access Tracking
      "3240205072723498": [
        { messenger_user_id: "3240205072723498", name: "gender", value: "m" },
        { messenger_user_id: "3240205072723498", name: "location", value: "0212" },
        { messenger_user_id: "3240205072723498", name: "main_menu", value: "tracking" },
        { messenger_user_id: "3240205072723498", name: "tracking_code", value: "123" },
      ]
    }

    people.each do |session_id, steps|
      steps.each do |step|
        puts "#{session_id}.#{step}"
        response = RestClient.post(route, step.to_json, headers)
        puts response.code
      end
    end
  end
end
