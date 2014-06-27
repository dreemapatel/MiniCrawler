package Connection;

import java.sql.*;


import org.jsoup.Jsoup;
import org.jsoup.nodes.Document;
import org.jsoup.nodes.Element;
import org.jsoup.select.Elements;
import java.util.*;

public class DatabaseOperations {
	
	Connection con = null;
	static ResultSet rs;
    Statement stmt = null;
    
    public DatabaseOperations(){
    	
    	try {			
			Class.forName("com.mysql.jdbc.Driver").newInstance();
			con = DriverManager.getConnection("jdbc:mysql://localhost:3306/mini_crawler","root","dreemaindia");
			stmt = con.createStatement();
	
			if(!con.isClosed())
				System.out.println("Successfully Connected!!!");
		} catch (SQLException e) {
			// TODO Auto-generated catch block
			e.printStackTrace();
		} catch (InstantiationException e) {
			// TODO Auto-generated catch block
			e.printStackTrace();
		} catch (IllegalAccessException e) {
			// TODO Auto-generated catch block
			e.printStackTrace();
		} catch (ClassNotFoundException e) {
			// TODO Auto-generated catch block
			e.printStackTrace();
		}
    	
    }
    
    public void extractLinks(String url, String keyword){
    			PreparedStatement ps= null;
    			PreparedStatement ps1= null;
    			PreparedStatement ps2= null;
    			PreparedStatement ps3= null;
    			PreparedStatement ps4= null;
    			PreparedStatement ps5= null;
    			
    			int depth=0;
    			
    			boolean isContain=false;
    			String parent=null;
    			int parent_id;
    			int start_id;
    			
    			try{
    				
    				
    				int rowcount;
    				
    	// first url and keyword will be inserted to crawl_inspector table			
    				
    				ps1=con.prepareStatement("insert into crawl_inspector (url, keyword) values (?,?)");	
    			
    				ps1.setString(1, url);
    				ps1.setString(2, keyword);
    				rowcount=ps1.executeUpdate();
    				if(rowcount>0)
    					System.out.println("inserted successfully");
    				else{
    					System.out.println("could not insert");
    				}   
    				
    // start_id will be fetched from crawl_inspector and will inserted to crawl_manager
    				ps4=con.prepareStatement("select start_id from crawl_inspector where url=? and keyword=?");
    				ps4.setString(1, url);
    				ps4.setString(2, keyword);
    				ResultSet rs1=ps4.executeQuery();
    				while(rs1.next()){
    				 start_id=rs1.getInt(1);
    				
    				  Document doc1= Jsoup.connect(url).get();
    				 if(doc1.text().contains(keyword))
    					 isContain=true;
    				 else
    					 isContain=false;
    				ps5=con.prepareStatement("insert into crawl_manager (start_id,url,isContain,parent_id,depth) values (?,?,?,?,?)");
    				ps5.setInt(1, start_id);
    				ps5.setString(2, url);
    				ps5.setBoolean(3, isContain);
    				ps5.setInt(4, 0);
    				ps5.setInt(5, depth);
    				rowcount=ps5.executeUpdate();
    				if(rowcount>0)
    					System.out.println("inserted into manager");
    				
    				depth++;
    	// will crawl till depth 3			
    				while(depth<=3){
    					ps2= con.prepareStatement("select url_id,url from crawl_manager where depth=?");
    					ps2.setInt(1, depth-1);
    					ResultSet rs2=ps2.executeQuery();
       					while (rs2.next()){
    						
    						parent_id=rs2.getInt(1);
    						parent=rs2.getString(2);
    						
    					    Document doc= Jsoup.connect(parent).get();
    					        
    						Elements links=doc.select("a[href]");
    						if(links.size()>0){
    						for(int i=10;i<15;i++){
    	
    						Element link=links.get(i);
    							
    						url=link.attr("abs:href"); //will select the links
    						  if(!url.contains("#") && !url.equals("/") && !url.contains("%") && !url.contains("javascript") && !url.contains("mailto") && url.contains("wikipedia.org") && !url.contains("?") && !url.contains(".jpg") && !url.contains("File") && !url.contains(".png") && !url.contains(".jpeg") && !url.contains(".pdf") && !url.contains("cgi-bin") && !url.contains("tmp") && !url.contains("scriptst")){
    								 Document doc2=Jsoup.connect(url).get();
    								 if(doc2.text().contains(keyword))
    									 isContain=true;
    								else 
    								 isContain=false;  
    								 
    								ps3=con.prepareStatement("insert ignore into crawl_manager (start_id,url,isContain,parent_id,depth) values (?,?,?,?,?)");
     								ps3.setInt(1, start_id);
     								ps3.setString(2, url);
     								ps3.setBoolean(3, isContain);
     								ps3.setInt(4, parent_id);
     								ps3.setInt(5, depth);
     								rowcount=ps3.executeUpdate(); 
    					
    							}
    						}
    					  }   
    				}
    						depth++;
    						
    				}
    				 	
    				}
    				
    			
    			}
    			catch(Exception e){
    				
    			}
    			
    			
    	     
    }

   
    
}
