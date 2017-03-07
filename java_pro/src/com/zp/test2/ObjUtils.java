package com.zp.test2;

import java.lang.reflect.Field;

public class ObjUtils {
	/**
	 * 将dataT中成员值不为空的赋值给returnT
	 * 
	 * @param returnT
	 * @param dataT
	 * @return
	 */
	public static <T extends MyCloneable> T getFieldValCopy(T returnT, T dataT) {
		if (returnT == null) {
			return dataT;
		}
		if (returnT != null && dataT != null) {
			Field[] fields = dataT.getClass().getDeclaredFields();
			try {
				T copyT=(T) returnT.clone();
				Class<?> returnTClass = copyT.getClass();
				for (Field field : fields) {
					field.setAccessible(true);

					Object valObject = field.get(dataT);
					if (valObject == null
							|| valObject.toString().trim().equals("")) {
						continue;
					}
					String fieldName = field.getName();
					Field fieldTemp = returnTClass.getDeclaredField(fieldName);
					fieldTemp.setAccessible(true);
					fieldTemp.set(copyT, valObject);

				}
				return copyT;
			} catch (Exception e) {
				e.printStackTrace();
			}
		}
		return returnT;
	}
}
