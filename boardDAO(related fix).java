package com.alpaca.board;

import java.sql.Connection;
import java.sql.PreparedStatement;
import java.sql.ResultSet;
import java.util.ArrayList;

import com.alpaca.common.JDBCUtil;

public class boardDAO {
	private Connection conn = null;
	private PreparedStatement stmt = null;
	private ResultSet rs = null;

	public String getDate() {
		String SQL = "select sysdate()";
		try {
			conn = JDBCUtil.getConnection();
			PreparedStatement pstmt = conn.prepareStatement(SQL);
			rs = pstmt.executeQuery();
			if (rs.next()) {
				return rs.getString(1);
			}
		} catch (Exception e) {
			e.printStackTrace();
		}
		return "";
	}

	public int getNext() {
		String SQL = "select bnum from board order by bnum desc";

		try {
			PreparedStatement pstmt = conn.prepareStatement(SQL);
			rs = pstmt.executeQuery();
			if (rs.next()) {
				return rs.getInt(1) + 1;
			}
			return 1;
		} catch (Exception e) {
			e.printStackTrace();
		}
		return -1;
	}
	
	public int getPage() {
		String sql = "select count(bnum) from board";
		try {
			conn = JDBCUtil.getConnection();
			stmt = conn.prepareStatement(sql);
			rs = stmt.executeQuery();
			if(rs.next()) {
				return rs.getInt(1);
			}
		}catch(Exception e) {
			e.printStackTrace();
		}
		return -1;
	}
	
	public void getView(int num) {
		String SQL = "update board set count= count + 1 where bnum = ?";
		try {
			conn = JDBCUtil.getConnection();
			PreparedStatement pstmt = conn.prepareStatement(SQL);
			pstmt.setInt(1, num);
			pstmt.executeUpdate();
		}catch (Exception e) {
			e.printStackTrace();
		}
	}

	public void boardInsert(String title, String writer, String content) {
		System.out.println("jdbc로 boardInsert() 기능 처리");
		String sql = "insert into board(bnum, title, writer, content, count, wridate) values (?,?,?,?,?,?)";
		try {
			conn = JDBCUtil.getConnection();
			stmt = conn.prepareStatement(sql);
			stmt.setInt(1, getNext());
			stmt.setString(2, title);
			stmt.setString(3, writer);
			stmt.setString(4, content);
			stmt.setInt(5, 1);
			stmt.setString(6, getDate());
			stmt.executeUpdate();
			System.out.println("boardInsert() try문 실행");
		} catch (Exception e) {
			e.printStackTrace();
		} finally {
			JDBCUtil.close(stmt, conn);
			System.out.println("boardInsert() finally문 실행");
		}

	}
	
	public void boardUpdate(int num, String title, String writer, String content) {
		System.out.println("jdbc로 boardUpdate() 기능 처리");
		String sql = "update board set title=?, writer=?, content=?, count=?, wridate=? where bnum=?";
		boardVO vo = new boardVO();
		try {
			conn = JDBCUtil.getConnection();
			stmt = conn.prepareStatement(sql);
			stmt.setString(1, title);
			stmt.setString(2, writer);
			stmt.setString(3, content);
			stmt.setInt(4, 1);
			stmt.setString(5, getDate());
			stmt.setInt(6, num);
			stmt.executeUpdate();
			System.out.println("boardUpdate() try문 실행");
		} catch (Exception e) {
			e.printStackTrace();
		} finally {
			JDBCUtil.close(stmt, conn);
			System.out.println("boardUpdate() finally문 실행");
		}

	}
	
	public void boardDelete(int num) {
		System.out.println("jdbc로 boardDelete() 기능 처리");
		String sql = "delete from board where bnum=?";
		boardVO vo = new boardVO();
		try {
			conn = JDBCUtil.getConnection();
			stmt = conn.prepareStatement(sql);
			stmt.setInt(1, num);
			stmt.executeUpdate();
			System.out.println("boardDelete() try문 실행");
		} catch (Exception e) {
			e.printStackTrace();
		} finally {
			JDBCUtil.close(stmt, conn);
			System.out.println("boardDelete() finally문 실행");
		}

	}

	public ArrayList<boardVO> boardList(int num) {
		System.out.println("jdbc로 boardList() 기능 처리");
		String sql = "select bnum, title, writer, content, count, wridate from board where bnum<? and bnum>? order by bnum desc limit 5";
		ArrayList<boardVO> al = new ArrayList<boardVO>();
		try {
			conn = JDBCUtil.getConnection();
			stmt = conn.prepareStatement(sql);
			stmt.setInt(1, num);
			stmt.setInt(2, num-6);
			rs = stmt.executeQuery();
			while (rs.next()) {
				boardVO vo = new boardVO();
				vo.setBnum(rs.getInt(1));
				vo.setTitle(rs.getString(2));
				vo.setWriter(rs.getString(3));
				vo.setContent(rs.getString(4));
				vo.setCount(rs.getInt(5));
				vo.setDate(rs.getString(6));
				al.add(vo);
			}
			System.out.println("boardList() try문 실행");
		} catch (Exception e) {
			e.printStackTrace();
		}
		return al;

	}
	
	public boolean boardNextPage(int num) {
		String SQL = "select * from board where bnum < ?";
		try {
			PreparedStatement pstmt = conn.prepareStatement(SQL);
			pstmt.setInt(1, getNext() - (num - 1) * 5);
			rs = pstmt.executeQuery();
			if (rs.next()) {
				return true;
			}
		} catch (Exception e) {
			e.printStackTrace();
		}
		return false;

	}
	
	public ArrayList<boardVO> boardView(int num) {
		System.out.println("jdbc로 boardView() 기능 처리");
		String sql = "select title, writer, content, wridate from board where bnum = ?";
		ArrayList<boardVO> al = new ArrayList<boardVO>();
		try {
			conn = JDBCUtil.getConnection();
			stmt = conn.prepareStatement(sql);
			stmt.setInt(1, num);
			rs = stmt.executeQuery();
			if (rs.next()) {
				boardVO vo = new boardVO();
				vo.setTitle(rs.getString(1));
				vo.setWriter(rs.getString(2));
				vo.setContent(rs.getString(3));
				vo.setDate(rs.getString(4));
				al.add(vo);
			}
			System.out.println("boardView() try문 실행");
		} catch (Exception e) {
			e.printStackTrace();
		}
		return al;

	}

}