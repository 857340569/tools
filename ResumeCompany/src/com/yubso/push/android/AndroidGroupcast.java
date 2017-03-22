package com.yubso.push.android;

import com.yubso.org.json.JSONArray;
import com.yubso.org.json.JSONObject;
import com.yubso.push.base.AndroidPush;

public class AndroidGroupcast extends AndroidPush {
	public AndroidGroupcast(String...tags) {
		try {
			this.setPredefinedKeyValue("type", "groupcast");
			if(tags!=null)
			{
				JSONObject filterJson = new JSONObject();
				JSONObject whereJson = new JSONObject();
				JSONArray tagArray = new JSONArray();
				for (String tag:tags) {
					JSONObject tempTag = new JSONObject();
					tempTag.put("tag", tag);
					tagArray.put(tempTag);
				}
				whereJson.put("and", tagArray);
				filterJson.put("where", whereJson);
				System.out.println(filterJson.toString());
				setPredefinedKeyValue("filter", filterJson);
			}
		} catch (Exception ex) {
			ex.printStackTrace();
			System.exit(1);
		}
	}
}
