package com.yubso.resumecompany.action;

import java.awt.Color;
import java.awt.Font;
import java.awt.Graphics;
import java.awt.image.BufferedImage;
import java.util.Random;

import com.sun.image.codec.jpeg.JPEGCodec;
import com.sun.image.codec.jpeg.JPEGImageEncoder;

public class CodeAction extends BaseAction{
	private String code;
	public String createCode() throws Exception{
	        response.setHeader("Pragma", "No-cache");
	    	response.setHeader("Cache-Control", "no-cache");
	    	response.setDateHeader("Expires", 0);
	    	response.flushBuffer();
	    	int width = 90;
	    	int height = 32;
	    	BufferedImage image = new BufferedImage(width, height,
	    			BufferedImage.TYPE_INT_RGB);
	    	Graphics g = image.getGraphics();
	    	Random random = new Random();
	    	g.setColor(getRandColor(200, 250));
	    	g.fillRect(0, 0, width, height);
	    	g.setFont(new Font("Times New Roman", Font.PLAIN, 22));
	    	g.setColor(getRandColor(160, 200));
	    	for (int i = 0; i < 100; i++) {
	    		int x = random.nextInt(width);
	    		int y = random.nextInt(height);
	    		int xl = random.nextInt(12);
	    		int yl = random.nextInt(12);
	    		g.drawLine(x, y, x + xl, y + yl);
	    	}
	    	String sRand = code;
	    	 for (int i = 0; i < sRand.length(); i++) {  
	    		String rand = sRand.substring(i, i+1);  
	    		g.setColor(new Color(20 + random.nextInt(110), 20 + random
	    				.nextInt(110), 20 + random.nextInt(110)));
	    		g.drawString(rand, 20 * i + 10, 24);
	    	}
	    	g.dispose();
	    	javax.servlet.ServletOutputStream imageOut = response.getOutputStream();  
		    JPEGImageEncoder encoder = JPEGCodec.createJPEGEncoder(imageOut);  
		    encoder.encode(image); 
		return "code";
	}
	private Color getRandColor(int fc, int bc) {  
	    Random random = new Random();  
	    if (fc > 255)  
	        fc = 255;  
	    if (bc > 255)  
	        bc = 255;  
	    int r = fc + random.nextInt(bc - fc);  
	    int g = fc + random.nextInt(bc - fc);  
	    int b = fc + random.nextInt(bc - fc);  
	    return new Color(r, g, b);  
	}
	public String getCode() {
		return code;
	}
	public void setCode(String code) {
		this.code = code;
	}
	
}
