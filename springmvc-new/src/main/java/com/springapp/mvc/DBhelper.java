package com.springapp.mvc;
import java.io.IOException;
import java.sql.*;
import java.util.Map;

import org.codehaus.jackson.map.ObjectMapper;

public class DBhelper
{
    public static final String url = "jdbc:mysql://localhost:3306/MyDB?"
            + "user=root&password=123456&useUnicode=true&characterEncoding=UTF8";
    public static final String name = "com.mysql.jdbc.Driver";
    public static final String user = "root";
    public static final String password = "123456";
    public Connection conn = null;
    public Statement pst = null;

    public DBhelper(String sql) {
        try {
            Class.forName(name);//指定连接类型
            conn = DriverManager.getConnection(url, user, password);//获取连接
            pst = conn.createStatement();
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
//insert
    public int insertsqlWithJsonstr(String jsonstr,String tablename)
    {
        ObjectMapper mapper = new ObjectMapper();
        try {
            Map<String, String> map = mapper.readValue(jsonstr, Map.class);

            StringBuilder sqlstr = new StringBuilder("insert into "+tablename+"(");
            for (String key : map.keySet()) {
            sqlstr.append(key+",");
            }
            sqlstr.delete(sqlstr.length()-1,sqlstr.length());
            sqlstr.append(") values(");
            for (String value : map.values()) {
                sqlstr.append(value+",");
            }
            sqlstr.delete(sqlstr.length()-1,sqlstr.length());
            sqlstr.append(")");
           // pst = conn.prepareStatement(sqlstr.toString());//准备执行语句
            int  i = pst.executeUpdate(sqlstr.toString());
            return i;

//            this.conn.prepareStatement.close();
//        this.conn.close();

        } catch (IOException e) {
            e.printStackTrace();
            return 0;
        } catch (SQLException e) {
            e.printStackTrace();
            return 0;

        }


    }
    //查询
    public int findsqlWithJsonstr(String jsonstr,String table)
    {

        ObjectMapper mapper = new ObjectMapper();
        try {
            Map<String, String> map = mapper.readValue(jsonstr, Map.class);

            StringBuilder sqlstr = new StringBuilder("select * from "+table+" where ");
            for (String key : map.keySet()) {
                sqlstr.append(key+"="+map.get(key)+" and ");
            }
            sqlstr.delete(sqlstr.length()-4,sqlstr.length());
           // pst = conn.prepareStatement(sqlstr.toString());//准备执行语句
            ResultSet rs = pst.executeQuery(sqlstr.toString());

            if (rs.next())
            {
                System.out.print("有数据");
            }
//            this.conn.prepareStatement.close();
//        this.conn.close();
            return 0;
        } catch (IOException e) {
            e.printStackTrace();
            return 0;
        } catch (SQLException e) {
            e.printStackTrace();
            return 0;

        }

    }
}
