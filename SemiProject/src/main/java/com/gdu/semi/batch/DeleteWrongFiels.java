package com.gdu.semi.batch;

import java.io.File;
import java.io.FilenameFilter;
import java.nio.file.Path;
import java.nio.file.Paths;
import java.util.ArrayList;
import java.util.Arrays;
import java.util.List;

import org.springframework.scheduling.annotation.EnableScheduling;
import org.springframework.scheduling.annotation.Scheduled;
import org.springframework.stereotype.Component;

import com.gdu.semi.domain.AttachDTO;
import com.gdu.semi.mapper.UploadBoardMapper;
import com.gdu.semi.util.MyFileUtil;

import lombok.AllArgsConstructor;

@AllArgsConstructor
@EnableScheduling
@Component
public class DeleteWrongFiels {
	
	private MyFileUtil myFileUtil;
	private UploadBoardMapper uploadBoardMapper;
	
	@Scheduled(cron="0 0 4 * * *")
	public void execute() {
		String path = myFileUtil.getYesterdayPath();
		
		List<AttachDTO> dbList = uploadBoardMapper.selectAttachListInYesterday();
		
		List<Path> pathList = new ArrayList<>();
		if(dbList != null && dbList.isEmpty() == false ) {
			for(AttachDTO attach : dbList) {
				pathList.add(Paths.get(path, attach.getFilesystem()));
			}
		}
		
		System.out.println("1  " + pathList.toString());
		
		File dir = new File(path);
		File[] wrongFiles = dir.listFiles(new FilenameFilter() {
			
			@Override
			public boolean accept(File dir, String name) {
					
				return !pathList.contains(new File(dir, name).toPath());
			}
		});
		
		System.out.println("2   " + Arrays.toString(wrongFiles));
		
		if(wrongFiles != null ) {
			for(File wrong : wrongFiles) {
				wrong.delete();
			}
		}
	}
}
