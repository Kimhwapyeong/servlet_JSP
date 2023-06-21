package fileUpload;

import java.sql.Connection;
import java.sql.PreparedStatement;
import java.sql.ResultSet;
import java.sql.SQLException;
import java.util.ArrayList;
import java.util.List;

import common.DBConnPool;

public class FileDao {

	public FileDao() {
		// TODO Auto-generated constructor stub
	}
	
	// 파일 정보를 저장 합니다.
	public int insertFile(FileDto dto) {
		int res = 0;
		String sql = "insert into myfile values (seq_myfile_num.nextval, ?, ?, ?, ?, ?, sysdate)";
		
		try(Connection conn = DBConnPool.getConnection();
				PreparedStatement psmt = conn.prepareStatement(sql);) {
			
			psmt.setString(1, dto.getName());
			psmt.setString(2, dto.getTitle());
			psmt.setString(3, dto.getCate());
			psmt.setString(4, dto.getOfile());
			psmt.setString(5, dto.getSfile());
			
			res = psmt.executeUpdate();
			
		} catch (SQLException e) {
			// TODO Auto-generated catch block
			e.printStackTrace();
		}
		return res;
	}
	
	// 파일 목록을 조회 합니다.
	public List<FileDto> getFileList(){
		List<FileDto> list = new ArrayList<FileDto>();
		String sql = "select * from myfile order by idx desc";
		
		try(Connection conn = DBConnPool.getConnection();
				PreparedStatement psmt = conn.prepareStatement(sql);) {
			
			
			ResultSet rs = psmt.executeQuery();
			while(rs.next()) {
				FileDto file = new FileDto();
				
				file.setIdx(rs.getString("idx")); 
				file.setName(rs.getString("name"));
				file.setTitle(rs.getString("title"));
				file.setCate(rs.getString("cate"));
				file.setOfile(rs.getString("ofile"));
				file.setSfile(rs.getString("sfile"));
				file.setPostdate(rs.getString("postdate"));
				
				list.add(file);
			}
			rs.close();
			
		} catch (SQLException e) {
			// TODO Auto-generated catch block
			e.printStackTrace();
		}
		return list;
	}
}
