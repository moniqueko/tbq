package com.thebookquotes.TBQ.common;

import org.apache.commons.io.FileUtils;
import org.slf4j.Logger;
import org.slf4j.LoggerFactory;
import org.springframework.util.StringUtils;
import org.springframework.web.multipart.MultipartFile;

import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;
import java.io.*;
import java.net.URLEncoder;
import java.text.Normalizer;
import java.util.UUID;

public class FileHandler {

    private static final Logger LOGGER = LoggerFactory.getLogger(FileHandler.class);

    /*
     ** 저장 실패 : return ""
     ** 저장 성공 : return url (저장경로, ex: "/downloads/file.txt")
     */
    public static String saveFileFromMultipart(MultipartFile multipartFile, String path) throws IOException {
        if (multipartFile != null) {

            String uniqueId = UUID.randomUUID() + "."
                    + multipartFile.getOriginalFilename().substring(multipartFile.getOriginalFilename().lastIndexOf(".") + 1);

            File target = new File(path);

            if (!target.exists()) {
                target.mkdirs();
                target.setReadable(true, false);
                target.setExecutable(true, false);
                target.setWritable(true, false);
            }

            String targetPath = path + "/" + uniqueId;

            File targetFile = new File(targetPath);

            try {
                InputStream fileStream = multipartFile.getInputStream();
                FileUtils.copyInputStreamToFile(fileStream, targetFile);
                return targetPath;
            } catch (IOException e) {
                FileUtils.forceDelete(targetFile);
                LOGGER.error("File InputStream To File Error :: " + e.getMessage());
            }
        }
        return "";
    }

    public static void fileDelete(String filePath) {

        if (!StringUtils.isEmpty(filePath)) {
            File file = new File(filePath);
            file.delete();
        }
    }

    public static void folderDelete(String folderPath) {
        if (!StringUtils.isEmpty(folderPath)) {
            File folder = new File(folderPath);

            if (folder.exists()) { //파일존재여부확인
                if (folder.isDirectory()) { //파일이 디렉토리인지 확인
                    File[] files = folder.listFiles();

                    if (files != null) {
                        for (File file : files) {
                            file.delete();
                        }
                    }
                }
                folder.delete();
            }
        }
    }

    public static void fileService(String downFile, String fileName, HttpServletResponse response, HttpServletRequest request) throws IOException {
        File file = new File(downFile);
        long fileLength = file.length();

        String typeFile = request.getServletContext().getMimeType(file.toString());

        if (typeFile == null) {
            response.setContentType("application/octet-stream");
        }

        String downName = Normalizer.normalize(fileName, Normalizer.Form.NFC);

        try {
            downName = URLEncoder.encode(fileName, "UTF-8").replaceAll("\\+", "%20").replaceAll("%26", "&").replaceAll("%2F", "_").replaceAll("%3A", ":").replaceAll("%3F", "?").replaceAll("%3D", "=");
        } catch (UnsupportedEncodingException e1) {
            LOGGER.error(e1.getMessage(), e1);
        }

        response.setHeader("Content-Disposition", "attachment; filename=\"" + downName + "\";");
        response.setHeader("Content-Transfer-Encoding", "binary");
        response.setHeader("Content-Type", "application/pdf; UTF-8");
        response.setHeader("Content-Length", "" + fileLength);
        response.setHeader("Pragma", "no-cache;");
        response.setHeader("Expires", "-1;");

        FileHandler.fileDownload(downFile, fileLength, response);

        FileInputStream fileInputStream = new FileInputStream(file);
        OutputStream os = response.getOutputStream();

        os.flush();
        os.close();
        fileInputStream.close();
    }

    public static void fileDownload(String filePath, long fileSize, HttpServletResponse response) {
        try (FileInputStream fis = new FileInputStream(filePath)) {

            OutputStream out = response.getOutputStream();

            int readCount = 0;
            byte[] buffer = new byte[Long.valueOf(fileSize).intValue()];

            while ((readCount = fis.read(buffer)) != -1) {
                out.write(buffer, 0, readCount);
            }

        } catch (Exception e) {
            e.printStackTrace();
        }
    }
}

