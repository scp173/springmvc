package com.springapp.mvc;
import java.sql.*;

public class DBhelper
{
    public static final String url = "jdbc:mysql://localhost:3306/MyDB?"
            + "user=root&password=123456&useUnicode=true&characterEncoding=UTF8";
    public static final String name = "com.mysql.jdbc.Driver";
    public static final String user = "root";
    public static final String password = "123456";
    public Connection conn = null;
    public PreparedStatement pst = null;

    public DBhelper(String sql) {
        try {
            Class.forName(name);//指定连接类型
            conn = DriverManager.getConnection(url, user, password);//获取连接
            pst = conn.prepareStatement(sql);//准备执行语句
        } catch (Exception e) {
            System.out.print(e);
            //e.printStackTrace();
        }
    }

    public void close() {
        try {
            this.conn.close();
            this.pst.close();
        } catch (SQLException e) {
            e.printStackTrace();
        }
    }

}
