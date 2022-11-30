package com.gdu.semi.mapper;

import java.util.List;
import java.util.Map;

import org.apache.ibatis.annotations.Mapper;

import com.gdu.semi.domain.CommentDTO;

@Mapper
public interface CommentMapper {
	public int selectCommentCount(int galleryBoardNo);
	public int insertComment(CommentDTO comments); // 원글
	public List<CommentDTO> selectCommentList(Map<String, Object> map);
	public int deleteComment(int commentsNo);
	public int insertReply(CommentDTO reply); // 댓글
}
