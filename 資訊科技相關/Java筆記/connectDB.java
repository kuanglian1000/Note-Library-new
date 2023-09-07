import java.sql.Connection;
import java.sql.DriverManager;
import java.sql.PreparedStatement;
import java.sql.ResultSet;

import com.mysql.cj.xdevapi.PreparableStatement;

public class connectDB {
  public static void main(String[] args) {
    System.out.println("Test");
    connectDB.getCitys();
  }


  public static void getCitys()
  {
    String sql = "select ID , Name from world.City";
    String jdbcUrl = "jdbc:mysql://localhost:3306/sys?serverTimezone=UTC&useSSL=false&useUnicode=true&characterEncoding=UTF-8";
    try (Connection conn = DriverManager.getConnection(jdbcUrl, "root", "54878916")) {
      PreparedStatement ps = conn.prepareStatement(sql);
      ResultSet rs = ps.executeQuery();
      while (rs.next()) {
        System.out.println(rs.getString("ID"));
      }

    } catch (Exception e) {
      e.printStackTrace();
    }

  }

}


// jdbc:mysql://localhost:3306/?user=root