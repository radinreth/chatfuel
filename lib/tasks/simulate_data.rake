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
        { messenger_user_id: "4178164752256231", name: "owso_info", value: "certify_docs" },
        { messenger_user_id: "4178164752256231", name: "certify_docs", value: "certify_docs_2" }
      ],
      "3412716758746938": [
        { messenger_user_id: "3412716758746938", name: "gender", value: "f" },
        { messenger_user_id: "3412716758746938", name: "location", value: "0212" },
        { messenger_user_id: "3412716758746938", name: "main_menu", value: "owso_info" },
        { messenger_user_id: "3412716758746938", name: "owso_info", value: "certify_docs" },
        { messenger_user_id: "3412716758746938", name: "certify_docs", value: "certify_docs_2" }
      ],
      "3165459796901632": [
        { messenger_user_id: "3165459796901632", name: "gender", value: "m" },
        { messenger_user_id: "3165459796901632", name: "location", value: "0204" },
        { messenger_user_id: "3165459796901632", name: "main_menu", value: "owso_info" },
        { messenger_user_id: "3165459796901632", name: "owso_info", value: "certify_docs" },
        { messenger_user_id: "3165459796901632", name: "certify_docs", value: "certify_docs_2" }
      ],
      "3015307228581930": [
        { messenger_user_id: "3015307228581930", name: "gender", value: "f" },
        { messenger_user_id: "3015307228581930", name: "location", value: "0206" },
        { messenger_user_id: "3015307228581930", name: "main_menu", value: "owso_info" },
        { messenger_user_id: "3015307228581930", name: "owso_info", value: "certify_docs" },
        { messenger_user_id: "3015307228581930", name: "certify_docs", value: "certify_docs_2" }
      ],
      "3015307228581931": [
        { messenger_user_id: "3015307228581931", name: "gender", value: "f" },
        { messenger_user_id: "3015307228581931", name: "location", value: "0203" },
        { messenger_user_id: "3015307228581931", name: "main_menu", value: "owso_info" },
        { messenger_user_id: "3015307228581931", name: "owso_info", value: "certify_docs" },
        { messenger_user_id: "3015307228581931", name: "certify_docs", value: "certify_docs_2" }
      ],
      "4952771681415409": [
        { messenger_user_id: "4952771681415409", name: "gender", value: "m" },
        { messenger_user_id: "4952771681415409", name: "location", value: "0000" },
        { messenger_user_id: "4952771681415409", name: "main_menu", value: "owso_info" },
        { messenger_user_id: "4952771681415409", name: "owso_info", value: "certify_docs" },
        { messenger_user_id: "4952771681415409", name: "certify_docs", value: "certify_docs_2" }
      ],
      "3400688933341054": [
        { messenger_user_id: "3400688933341054", name: "gender", value: "m" },
        { messenger_user_id: "3400688933341054", name: "location", value: "0000" },
        { messenger_user_id: "3400688933341054", name: "main_menu", value: "owso_info" },
        { messenger_user_id: "3400688933341054", name: "owso_info", value: "certify_docs" },
        { messenger_user_id: "3400688933341054", name: "certify_docs", value: "certify_docs_2" }
      ],
      "3000399930077662": [
        { messenger_user_id: "3000399930077662", name: "gender", value: "m" },
        { messenger_user_id: "3000399930077662", name: "location", value: "0204" },
        { messenger_user_id: "3000399930077662", name: "main_menu", value: "owso_info" },
        { messenger_user_id: "3000399930077662", name: "owso_info", value: "certify_docs" },
        { messenger_user_id: "3000399930077662", name: "certify_docs", value: "certify_docs_2" }
      ],
      "3258467737601273": [
        { messenger_user_id: "3258467737601273", name: "gender", value: "f" },
        { messenger_user_id: "3258467737601273", name: "location", value: "0203" },
        { messenger_user_id: "3258467737601273", name: "main_menu", value: "owso_info" },
        { messenger_user_id: "3258467737601273", name: "owso_info", value: "certify_docs" },
        { messenger_user_id: "3258467737601273", name: "certify_docs", value: "certify_docs_2" }
      ],
      "3480802098620826": [
        { messenger_user_id: "3480802098620826", name: "gender", value: "f" },
        { messenger_user_id: "3480802098620826", name: "location", value: "0203" },
        { messenger_user_id: "3480802098620826", name: "main_menu", value: "owso_info" },
        { messenger_user_id: "3480802098620826", name: "owso_info", value: "certify_docs" },
        { messenger_user_id: "3480802098620826", name: "certify_docs", value: "certify_docs_2" }
      ],
      "2955621404561393": [
        { messenger_user_id: "2955621404561393", name: "gender", value: "m" },
        { messenger_user_id: "2955621404561393", name: "location", value: "0000" },
        { messenger_user_id: "2955621404561393", name: "main_menu", value: "owso_info" },
        { messenger_user_id: "2955621404561393", name: "owso_info", value: "certify_docs" },
        { messenger_user_id: "2955621404561393", name: "certify_docs", value: "certify_docs_2" }
      ],
      "3135278626509159": [
        { messenger_user_id: "3135278626509159", name: "gender", value: "m" },
        { messenger_user_id: "3135278626509159", name: "location", value: "0000" },
        { messenger_user_id: "3135278626509159", name: "main_menu", value: "owso_info" },
        { messenger_user_id: "3135278626509159", name: "owso_info", value: "certify_docs" },
        { messenger_user_id: "3135278626509159", name: "certify_docs", value: "certify_docs_2" }
      ],
      "3226399517435560": [
        { messenger_user_id: "3226399517435560", name: "gender", value: "f" },
        { messenger_user_id: "3226399517435560", name: "location", value: "0202" },
        { messenger_user_id: "3226399517435560", name: "main_menu", value: "owso_info" },
        { messenger_user_id: "3226399517435560", name: "owso_info", value: "certify_docs" },
        { messenger_user_id: "3226399517435560", name: "certify_docs", value: "certify_docs_2" }
      ],
      "3336822606375325": [
        { messenger_user_id: "3336822606375325", name: "gender", value: "f" },
        { messenger_user_id: "3336822606375325", name: "location", value: "0202" },
        { messenger_user_id: "3336822606375325", name: "main_menu", value: "owso_info" },
        { messenger_user_id: "3336822606375325", name: "owso_info", value: "certify_docs" },
        { messenger_user_id: "3336822606375325", name: "certify_docs", value: "certify_docs_2" }
      ],
      "3152578874869482": [
        { messenger_user_id: "3152578874869482", name: "gender", value: "f" },
        { messenger_user_id: "3152578874869482", name: "location", value: "0206" },
        { messenger_user_id: "3152578874869482", name: "main_menu", value: "owso_info" },
        { messenger_user_id: "3152578874869482", name: "owso_info", value: "certify_docs" },
        { messenger_user_id: "3152578874869482", name: "certify_docs", value: "certify_docs_2" }
      ],
      "4629929910352300": [
        { messenger_user_id: "4629929910352300", name: "gender", value: "f" },
        { messenger_user_id: "4629929910352300", name: "location", value: "0202" },
        { messenger_user_id: "4629929910352300", name: "main_menu", value: "owso_info" },
        { messenger_user_id: "4629929910352300", name: "owso_info", value: "certify_docs" },
        { messenger_user_id: "4629929910352300", name: "certify_docs", value: "certify_docs_2" }
      ],
      "3201578793252614": [
        { messenger_user_id: "3201578793252614", name: "gender", value: "f" },
        { messenger_user_id: "3201578793252614", name: "location", value: "0212" },
        { messenger_user_id: "3201578793252614", name: "main_menu", value: "owso_info" },
        { messenger_user_id: "3201578793252614", name: "owso_info", value: "certify_docs" },
        { messenger_user_id: "3201578793252614", name: "certify_docs", value: "certify_docs_2" }
      ],
      "4230655077009681": [
        { messenger_user_id: "4230655077009681", name: "gender", value: "f" },
        { messenger_user_id: "4230655077009681", name: "location", value: "0000" },
        { messenger_user_id: "4230655077009681", name: "main_menu", value: "owso_info" },
        { messenger_user_id: "4230655077009681", name: "owso_info", value: "certify_docs" },
        { messenger_user_id: "4230655077009681", name: "certify_docs", value: "certify_docs_2" }
      ],
      "3654502641227988": [
        { messenger_user_id: "3654502641227988", name: "gender", value: "m" },
        { messenger_user_id: "3654502641227988", name: "location", value: "0212" },
        { messenger_user_id: "3654502641227988", name: "main_menu", value: "owso_info" },
        { messenger_user_id: "3654502641227988", name: "owso_info", value: "certify_docs" },
        { messenger_user_id: "3654502641227988", name: "certify_docs", value: "certify_docs_2" }
      ],
      "4287752687961655": [
        { messenger_user_id: "4287752687961655", name: "gender", value: "m" },
        { messenger_user_id: "4287752687961655", name: "location", value: "0206" },
        { messenger_user_id: "4287752687961655", name: "main_menu", value: "owso_info" },
        { messenger_user_id: "4287752687961655", name: "owso_info", value: "certify_docs" },
        { messenger_user_id: "4287752687961655", name: "certify_docs", value: "certify_docs_2" }
      ],
      "4170205696385695": [
        { messenger_user_id: "4170205696385695", name: "gender", value: "f" },
        { messenger_user_id: "4170205696385695", name: "location", value: "0204" },
        { messenger_user_id: "4170205696385695", name: "main_menu", value: "owso_info" },
        { messenger_user_id: "4170205696385695", name: "owso_info", value: "certify_docs" },
        { messenger_user_id: "4170205696385695", name: "certify_docs", value: "certify_docs_2" }
      ],
      "4180833888625371": [
        { messenger_user_id: "4180833888625371", name: "gender", value: "m" },
        { messenger_user_id: "4180833888625371", name: "location", value: "0202" },
        { messenger_user_id: "4180833888625371", name: "main_menu", value: "owso_info" },
        { messenger_user_id: "4180833888625371", name: "owso_info", value: "certify_docs" },
        { messenger_user_id: "4180833888625371", name: "certify_docs", value: "certify_docs_2" }
      ],
      "4338071799567081": [
        { messenger_user_id: "4338071799567081", name: "gender", value: "m" },
        { messenger_user_id: "4338071799567081", name: "location", value: "0000" },
        { messenger_user_id: "4338071799567081", name: "main_menu", value: "owso_info" },
        { messenger_user_id: "4338071799567081", name: "owso_info", value: "certify_docs" },
        { messenger_user_id: "4338071799567081", name: "certify_docs", value: "certify_docs_2" }
      ],
      "3342485835818702": [
        { messenger_user_id: "3342485835818702", name: "gender", value: "f" },
        { messenger_user_id: "3342485835818702", name: "location", value: "0202" },
        { messenger_user_id: "3342485835818702", name: "main_menu", value: "owso_info" },
        { messenger_user_id: "3342485835818702", name: "owso_info", value: "certify_docs" },
        { messenger_user_id: "3342485835818702", name: "certify_docs", value: "certify_docs_2" }
      ],
      "3255000631245237": [
        { messenger_user_id: "3255000631245237", name: "gender", value: "f" },
        { messenger_user_id: "3255000631245237", name: "location", value: "0206" },
        { messenger_user_id: "3255000631245237", name: "main_menu", value: "owso_info" },
        { messenger_user_id: "3255000631245237", name: "owso_info", value: "certify_docs" },
        { messenger_user_id: "3255000631245237", name: "certify_docs", value: "certify_docs_2" }
      ],
      "4233493916725130": [
        { messenger_user_id: "4233493916725130", name: "gender", value: "f" },
        { messenger_user_id: "4233493916725130", name: "location", value: "0202" },
        { messenger_user_id: "4233493916725130", name: "main_menu", value: "owso_info" },
        { messenger_user_id: "4233493916725130", name: "owso_info", value: "certify_docs" },
        { messenger_user_id: "4233493916725130", name: "certify_docs", value: "certify_docs_2" }
      ],
      "3782073135152856": [
        { messenger_user_id: "3782073135152856", name: "gender", value: "f" },
        { messenger_user_id: "3782073135152856", name: "location", value: "0212" },
        { messenger_user_id: "3782073135152856", name: "main_menu", value: "owso_info" },
        { messenger_user_id: "3782073135152856", name: "owso_info", value: "certify_docs" },
        { messenger_user_id: "3782073135152856", name: "certify_docs", value: "certify_docs_2" }
      ],
      "2874198989351069": [
        { messenger_user_id: "2874198989351069", name: "gender", value: "f" },
        { messenger_user_id: "2874198989351069", name: "location", value: "0212" },
        { messenger_user_id: "2874198989351069", name: "main_menu", value: "owso_info" },
        { messenger_user_id: "2874198989351069", name: "owso_info", value: "certify_docs" },
        { messenger_user_id: "2874198989351069", name: "certify_docs", value: "certify_docs_2" }
      ],
      "2663061130462149": [
        { messenger_user_id: "2663061130462149", name: "gender", value: "f" },
        { messenger_user_id: "2663061130462149", name: "location", value: "0206" },
        { messenger_user_id: "2663061130462149", name: "main_menu", value: "owso_info" },
        { messenger_user_id: "2663061130462149", name: "owso_info", value: "certify_docs" },
        { messenger_user_id: "2663061130462149", name: "certify_docs", value: "certify_docs_2" }
      ],
      "3153690364712413": [
        { messenger_user_id: "3153690364712413", name: "gender", value: "f" },
        { messenger_user_id: "3153690364712413", name: "location", value: "0212" },
        { messenger_user_id: "3153690364712413", name: "main_menu", value: "owso_info" },
        { messenger_user_id: "3153690364712413", name: "owso_info", value: "certify_docs" },
        { messenger_user_id: "3153690364712413", name: "certify_docs", value: "certify_docs_2" }
      ],
      "3415736891810389": [
        { messenger_user_id: "3415736891810389", name: "gender", value: "m" },
        { messenger_user_id: "3415736891810389", name: "location", value: "0202" },
        { messenger_user_id: "3415736891810389", name: "main_menu", value: "owso_info" },
        { messenger_user_id: "3415736891810389", name: "owso_info", value: "certify_docs" },
        { messenger_user_id: "3415736891810389", name: "certify_docs", value: "certify_docs_2" }
      ],
      "4041914925883999": [
        { messenger_user_id: "4041914925883999", name: "gender", value: "f" },
        { messenger_user_id: "4041914925883999", name: "location", value: "0206" },
        { messenger_user_id: "4041914925883999", name: "main_menu", value: "owso_info" },
        { messenger_user_id: "4041914925883999", name: "owso_info", value: "certify_docs" },
        { messenger_user_id: "4041914925883999", name: "certify_docs", value: "certify_docs_2" }
      ],
      "3184352338347189": [
        { messenger_user_id: "3184352338347189", name: "gender", value: "m" },
        { messenger_user_id: "3184352338347189", name: "location", value: "0206" },
        { messenger_user_id: "3184352338347189", name: "main_menu", value: "owso_info" },
        { messenger_user_id: "3184352338347189", name: "owso_info", value: "certify_docs" },
        { messenger_user_id: "3184352338347189", name: "certify_docs", value: "certify_docs_2" }
      ],
      "4492970497387280": [
        { messenger_user_id: "4492970497387280", name: "gender", value: "m" },
        { messenger_user_id: "4492970497387280", name: "location", value: "0204" },
        { messenger_user_id: "4492970497387280", name: "main_menu", value: "owso_info" },
        { messenger_user_id: "4492970497387280", name: "owso_info", value: "certify_docs" },
        { messenger_user_id: "4492970497387280", name: "certify_docs", value: "certify_docs_2" }
      ],
      "3252163604844051": [
        { messenger_user_id: "3252163604844051", name: "gender", value: "m" },
        { messenger_user_id: "3252163604844051", name: "location", value: "0000" },
        { messenger_user_id: "3252163604844051", name: "main_menu", value: "owso_info" },
        { messenger_user_id: "3252163604844051", name: "owso_info", value: "certify_docs" },
        { messenger_user_id: "3252163604844051", name: "certify_docs", value: "certify_docs_2" }
      ],
      "3192641317523703": [
        { messenger_user_id: "3192641317523703", name: "gender", value: "f" },
        { messenger_user_id: "3192641317523703", name: "location", value: "0000" },
        { messenger_user_id: "3192641317523703", name: "main_menu", value: "owso_info" },
        { messenger_user_id: "3192641317523703", name: "owso_info", value: "certify_docs" },
        { messenger_user_id: "3192641317523703", name: "certify_docs", value: "certify_docs_2" }
      ],
      "3443721415685513": [
        { messenger_user_id: "3443721415685513", name: "gender", value: "f" },
        { messenger_user_id: "3443721415685513", name: "location", value: "0204" },
        { messenger_user_id: "3443721415685513", name: "main_menu", value: "owso_info" },
        { messenger_user_id: "3443721415685513", name: "owso_info", value: "certify_docs" },
        { messenger_user_id: "3443721415685513", name: "certify_docs", value: "certify_docs_2" }
      ],
      "3245666842135192": [
        { messenger_user_id: "3245666842135192", name: "gender", value: "m" },
        { messenger_user_id: "3245666842135192", name: "location", value: "0000" },
        { messenger_user_id: "3245666842135192", name: "main_menu", value: "owso_info" },
        { messenger_user_id: "3245666842135192", name: "owso_info", value: "certify_docs" },
        { messenger_user_id: "3245666842135192", name: "certify_docs", value: "certify_docs_2" }
      ],
      "3245356632210297": [
        { messenger_user_id: "3245356632210297", name: "gender", value: "m" },
        { messenger_user_id: "3245356632210297", name: "location", value: "0202" },
        { messenger_user_id: "3245356632210297", name: "main_menu", value: "owso_info" },
        { messenger_user_id: "3245356632210297", name: "owso_info", value: "certify_docs" },
        { messenger_user_id: "3245356632210297", name: "certify_docs", value: "certify_docs_2" }
      ],
      "3831831780167354": [
        { messenger_user_id: "3831831780167354", name: "gender", value: "f" },
        { messenger_user_id: "3831831780167354", name: "location", value: "0203" },
        { messenger_user_id: "3831831780167354", name: "main_menu", value: "owso_info" },
        { messenger_user_id: "3831831780167354", name: "owso_info", value: "certify_docs" },
        { messenger_user_id: "3831831780167354", name: "certify_docs", value: "certify_docs_2" }
      ],
      "4185198781554788": [
        { messenger_user_id: "4185198781554788", name: "gender", value: "m" },
        { messenger_user_id: "4185198781554788", name: "location", value: "0212" },
        { messenger_user_id: "4185198781554788", name: "main_menu", value: "owso_info" },
        { messenger_user_id: "4185198781554788", name: "owso_info", value: "certify_docs" },
        { messenger_user_id: "4185198781554788", name: "certify_docs", value: "certify_docs_2" }
      ],
      "3154945291227644": [
        { messenger_user_id: "3154945291227644", name: "gender", value: "f" },
        { messenger_user_id: "3154945291227644", name: "location", value: "0212" },
        { messenger_user_id: "3154945291227644", name: "main_menu", value: "owso_info" },
        { messenger_user_id: "3154945291227644", name: "owso_info", value: "certify_docs" },
        { messenger_user_id: "3154945291227644", name: "certify_docs", value: "certify_docs_2" }
      ],
      "3471402996217734": [
        { messenger_user_id: "3471402996217734", name: "gender", value: "f" },
        { messenger_user_id: "3471402996217734", name: "location", value: "0206" },
        { messenger_user_id: "3471402996217734", name: "main_menu", value: "owso_info" },
        { messenger_user_id: "3471402996217734", name: "owso_info", value: "certify_docs" },
        { messenger_user_id: "3471402996217734", name: "certify_docs", value: "certify_docs_2" }
      ],
      "3156667731088013": [
        { messenger_user_id: "3156667731088013", name: "gender", value: "f" },
        { messenger_user_id: "3156667731088013", name: "location", value: "0203" },
        { messenger_user_id: "3156667731088013", name: "main_menu", value: "owso_info" },
        { messenger_user_id: "3156667731088013", name: "owso_info", value: "certify_docs" },
        { messenger_user_id: "3156667731088013", name: "certify_docs", value: "certify_docs_2" }
      ],
      "3918844021475900": [
        { messenger_user_id: "3918844021475900", name: "gender", value: "m" },
        { messenger_user_id: "3918844021475900", name: "location", value: "0203" },
        { messenger_user_id: "3918844021475900", name: "main_menu", value: "owso_info" },
        { messenger_user_id: "3918844021475900", name: "owso_info", value: "certify_docs" },
        { messenger_user_id: "3918844021475900", name: "certify_docs", value: "certify_docs_2" }
      ],
      "4181069525298843": [
        { messenger_user_id: "4181069525298843", name: "gender", value: "m" },
        { messenger_user_id: "4181069525298843", name: "location", value: "0204" },
        { messenger_user_id: "4181069525298843", name: "main_menu", value: "owso_info" },
        { messenger_user_id: "4181069525298843", name: "owso_info", value: "certify_docs" },
        { messenger_user_id: "4181069525298843", name: "certify_docs", value: "certify_docs_2" }
      ],
      "3422429487777774": [
        { messenger_user_id: "3422429487777774", name: "gender", value: "f" },
        { messenger_user_id: "3422429487777774", name: "location", value: "0202" },
        { messenger_user_id: "3422429487777774", name: "main_menu", value: "owso_info" },
        { messenger_user_id: "3422429487777774", name: "owso_info", value: "certify_docs" },
        { messenger_user_id: "3422429487777774", name: "certify_docs", value: "certify_docs_2" }
      ],
      "3124056997709874": [
        { messenger_user_id: "3124056997709874", name: "gender", value: "f" },
        { messenger_user_id: "3124056997709874", name: "location", value: "0000" },
        { messenger_user_id: "3124056997709874", name: "main_menu", value: "owso_info" },
        { messenger_user_id: "3124056997709874", name: "owso_info", value: "certify_docs" },
        { messenger_user_id: "3124056997709874", name: "certify_docs", value: "certify_docs_2" }
      ],
      "3438416749536620": [
        { messenger_user_id: "3438416749536620", name: "gender", value: "f" },
        { messenger_user_id: "3438416749536620", name: "location", value: "0204" },
        { messenger_user_id: "3438416749536620", name: "main_menu", value: "owso_info" },
        { messenger_user_id: "3438416749536620", name: "owso_info", value: "certify_docs" },
        { messenger_user_id: "3438416749536620", name: "certify_docs", value: "certify_docs_2" }
      ],
      "2990701274388584": [
        { messenger_user_id: "2990701274388584", name: "gender", value: "m" },
        { messenger_user_id: "2990701274388584", name: "location", value: "0202" },
        { messenger_user_id: "2990701274388584", name: "main_menu", value: "owso_info" },
        { messenger_user_id: "2990701274388584", name: "owso_info", value: "certify_docs" },
        { messenger_user_id: "2990701274388584", name: "certify_docs", value: "certify_docs_2" }
      ],
      "4481858791839378": [
        { messenger_user_id: "4481858791839378", name: "gender", value: "f" },
        { messenger_user_id: "4481858791839378", name: "location", value: "0212" },
        { messenger_user_id: "4481858791839378", name: "main_menu", value: "owso_info" },
        { messenger_user_id: "4481858791839378", name: "owso_info", value: "certify_docs" },
        { messenger_user_id: "4481858791839378", name: "certify_docs", value: "certify_docs_2" }
      ],
      "3173911022655997": [
        { messenger_user_id: "3173911022655997", name: "gender", value: "f" },
        { messenger_user_id: "3173911022655997", name: "location", value: "0000" },
        { messenger_user_id: "3173911022655997", name: "main_menu", value: "owso_info" },
        { messenger_user_id: "3173911022655997", name: "owso_info", value: "certify_docs" },
        { messenger_user_id: "3173911022655997", name: "certify_docs", value: "certify_docs_2" }
      ],
      "3348614328549380": [
        { messenger_user_id: "3348614328549380", name: "gender", value: "f" },
        { messenger_user_id: "3348614328549380", name: "location", value: "0204" },
        { messenger_user_id: "3348614328549380", name: "main_menu", value: "owso_info" },
        { messenger_user_id: "3348614328549380", name: "owso_info", value: "certify_docs" },
        { messenger_user_id: "3348614328549380", name: "certify_docs", value: "certify_docs_2" }
      ],
      "3051476141647665": [
        { messenger_user_id: "3051476141647665", name: "gender", value: "m" },
        { messenger_user_id: "3051476141647665", name: "location", value: "0212" },
        { messenger_user_id: "3051476141647665", name: "main_menu", value: "owso_info" },
        { messenger_user_id: "3051476141647665", name: "owso_info", value: "certify_docs" },
        { messenger_user_id: "3051476141647665", name: "certify_docs", value: "certify_docs_2" }
      ],
      "3215220565234269": [
        { messenger_user_id: "3215220565234269", name: "gender", value: "m" },
        { messenger_user_id: "3215220565234269", name: "location", value: "0206" },
        { messenger_user_id: "3215220565234269", name: "main_menu", value: "owso_info" },
        { messenger_user_id: "3215220565234269", name: "owso_info", value: "certify_docs" },
        { messenger_user_id: "3215220565234269", name: "certify_docs", value: "certify_docs_2" }
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
        puts response.status
      end
    end
  end
end
