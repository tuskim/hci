package comm.util;

import java.awt.Color;
import java.awt.Font;
import java.awt.Graphics2D;
import java.awt.Image;
import java.awt.image.BufferedImage;
import java.awt.image.PixelGrabber;
import java.awt.image.RenderedImage;
import java.io.File;
import java.io.IOException;
import java.util.StringTokenizer;

import javax.imageio.ImageIO;
import javax.media.jai.JAI;
import javax.media.jai.RenderedOp;
import javax.swing.ImageIcon;

import devon.core.config.LConfiguration;
import devon.core.log.LLog;

import comm.ftp.FtpUtil;


public class ImageUtil {
        public static final int RATIO = 0;
        public static final int SAME = -1;

        // src 는 소스 이미지 입니다. 원본 이미지겠죠 변환하기전에 앞단에서 파일 유무등 체크한다음 ^^
        // dest 는 변환되어 저장될 파일입니다. src, dest 둘다 절대경로입니다.
        // 아 파일이니까 상관없을듯도 하네요 ^^
        //whidth 는 이미지 가로  height 는 이미지 높이
        public static void resize(File src, File dest, double width, double height, boolean ratioOpt) {
            Image srcImg = null;

//            RenderedImage srcBufImg = null;
            BufferedImage srcBufImg = null;
            RenderedOp tifsrc = null;
            int srcWidth  = 0;
            int srcHeight = 0;

            try {
             String suffix = src.getName().substring(src.getName().lastIndexOf('.')+1).toLowerCase();
             if (suffix.equals("png") || suffix.equals("gif")) {
                 srcBufImg = ImageIO.read(src);
             } else if (suffix.equals("bmp") || suffix.equals("tif")) { //요부분은 제가 추가 JAI를 사용해서 버퍼이미지를 헤헤헤 ^^
                 tifsrc = JAI.create("fileload", src.getPath());
                 srcImg = tifsrc.getAsBufferedImage();

             } else {
                 // BMP가 아닌 경우(jpeg) ImageIcon을 활용해서 Image 생성
                 // 이렇게 하는 이유는 getScaledInstance를 통해 구한 이미지를
                 // PixelGrabber.grabPixels로 리사이즈 할때
                 // 빠르게 처리하기 위함이다.
                 srcImg = new ImageIcon(src.getAbsolutePath()).getImage();
             }


             if (suffix.equals("png") || suffix.equals("gif")) {
                 srcWidth  = srcBufImg.getWidth();
                 srcHeight = srcBufImg.getHeight();
             } else {
                 srcWidth  = srcImg.getWidth(null);
                 srcHeight = srcImg.getHeight(null);
             }

             double destWidth = -1, destHeight = -1;
             double  ratio_width  = 1.000;
             double  ratio_height = 1.000;
             double ratio = 1.000;
             if (ratioOpt) {

                 if ( srcWidth > width || srcHeight > height) {
                     ratio_width  = width  / srcWidth ;
                     ratio_height = height / srcHeight;

                     if (ratio_width > ratio_height)
                         ratio = ratio_height;
                     else
                         ratio = ratio_width;
                 }

                 destWidth   = (int)Math.round( srcWidth  * ratio);
                 destHeight  = (int)Math.round( srcHeight * ratio);

             } else {
                 if (width == SAME) {
                     destWidth = srcWidth;
                 } else if (width > 0) {
                     destWidth = width;
                 }
                 if (height == SAME) {
                     destHeight = srcHeight;
                 } else if (height > 0) {
                     destHeight = height;
                 }

                 if (width == RATIO && height == RATIO) {
                     destWidth = srcWidth;
                     destHeight = srcHeight;
                 } else if (width == RATIO) {
                     ratio = ((double)destHeight) / ((double)srcHeight);
                     destWidth = (int)((double)srcWidth * ratio);
                 } else if (height == RATIO) {
                     ratio = ((double)destWidth) / ((double)srcWidth);
                     destHeight = (int)((double)srcHeight * ratio);
                 }
             }
             Image imgTarget = null;
             if (suffix.equals("png") || suffix.equals("gif")) {
                 imgTarget = srcBufImg.getScaledInstance((int)destWidth, (int)destHeight, Image.SCALE_SMOOTH);
             } else {
                 imgTarget = srcImg.getScaledInstance((int)destWidth, (int)destHeight, Image.SCALE_SMOOTH);
             }
             int pixels[] = new int[(int)destWidth * (int)destHeight];
             PixelGrabber pg = new PixelGrabber(imgTarget, 0, 0, (int)destWidth, (int)destHeight, pixels, 0, (int)destWidth);
             try {
                 pg.grabPixels();
             } catch (InterruptedException e) {
                 throw new IOException(e.getMessage());
             }

             BufferedImage destImg = new BufferedImage((int)destWidth, (int)destHeight, BufferedImage.TYPE_INT_RGB);
             destImg.setRGB(0, 0, (int)destWidth, (int)destHeight, pixels, 0, (int)destWidth);

             ImageIO.write((RenderedImage) destImg, "jpg", dest);

            } catch ( Exception ex ) {
                ex.printStackTrace();
                System.out.println(ex.toString());
            }

        }


        // 파일서버로 부터 파일을 was서버로 내려 받아
        // 이미지에 정보를 담아 이미지를 새로 만들어 파일서버로 올린다.
        public static void infoFileMake(String FilePath, String srcFileName, String pointPath, String destFileName, String info, double width, double height) {
            Image srcImg = null;

//            RenderedImage srcBufImg = null;
            BufferedImage srcBufImg = null;
            RenderedOp tifsrc = null;
            int srcWidth  = 0;
            int srcHeight = 0;

            Image arwImg   = null;
            RenderedOp arwsrc   = null;

            try {

                String localFile = FtpUtil.fileToWasDown(srcFileName, FilePath + "/" + srcFileName);

                File src = new File(localFile);

                int idx = srcFileName.lastIndexOf(".");
                String suffix = srcFileName.substring(idx) ;

                if (suffix.equals("png") || suffix.equals("gif")) {
                    srcBufImg = ImageIO.read(src);
                } else if (suffix.equals("bmp") || suffix.equals("tif")) { //요부분은 제가 추가 JAI를 사용해서 버퍼이미지를 헤헤헤 ^^
                    tifsrc = JAI.create("fileload", src.getPath());
                    srcImg = tifsrc.getAsBufferedImage();
                } else {
                    // BMP가 아닌 경우(jpeg) ImageIcon을 활용해서 Image 생성
                    // 이렇게 하는 이유는 getScaledInstance를 통해 구한 이미지를
                    // PixelGrabber.grabPixels로 리사이즈 할때
                    // 빠르게 처리하기 위함이다.
                     srcImg = new ImageIcon(src.getAbsolutePath()).getImage();
                }


                if (suffix.equals("png") || suffix.equals("gif")) {
                    srcWidth  = srcBufImg.getWidth();
                    srcHeight = srcBufImg.getHeight();
                } else {
                    srcWidth  = srcImg.getWidth(null);
                    srcHeight = srcImg.getHeight(null);
                }

                double destWidth = -1, destHeight = -1;
                double ratio = 1.000;
                double  ratio_width  = 1.000;
                double  ratio_height = 1.000;
//                if ( srcWidth > width || srcHeight > height) {
                    ratio_width  = width  / srcWidth ;
                    ratio_height = height / srcHeight;

                    if (ratio_width > ratio_height)
                        ratio = ratio_height;
                    else
                        ratio = ratio_width;
//                }

                destWidth   = (int)Math.round( srcWidth  * ratio);
                destHeight  = (int)Math.round( srcHeight * ratio);

                Image imgTarget = null;
                if (suffix.equals("png") || suffix.equals("gif")) {
                    imgTarget = srcBufImg.getScaledInstance((int)destWidth, (int)destHeight, Image.SCALE_DEFAULT);
                } else {
                    imgTarget = srcImg.getScaledInstance((int)destWidth, (int)destHeight, Image.SCALE_DEFAULT );
                }
                int pixels[] = new int[(int)destWidth * (int)destHeight];
                PixelGrabber pg = new PixelGrabber(imgTarget, 0, 0, (int)destWidth, (int)destHeight, pixels, 0, (int)destWidth);
                try {
                    pg.grabPixels();
                } catch (InterruptedException e) {
                    throw new IOException(e.getMessage());
                }

                BufferedImage destImg = new BufferedImage((int)destWidth, (int)destHeight, BufferedImage.TYPE_INT_RGB);
                destImg.setRGB(0, 0, (int)destWidth, (int)destHeight, pixels, 0, (int)destWidth);

                StringTokenizer imgInfo = new StringTokenizer(info , "§");

//              그림을 그리기 위해 Graphics2D를 얻어온다.
                Graphics2D graphics = destImg.createGraphics();

                graphics.setColor(Color.BLACK);
                graphics.setFont(new Font("굴림체", 0, 12));

                String bun = "";
                String cmt    = "";
                int xPos = 0;
                int yPos = 0;

                while(imgInfo.hasMoreTokens()){
                    StringTokenizer drawInfo = new StringTokenizer(imgInfo.nextToken() , ",");

                    if (drawInfo.nextToken().equals("arw")) {

                        bun = drawInfo.nextToken();
                        graphics.setFont(new Font("굴림체", 1, 20));
                        xPos = Integer.parseInt(drawInfo.nextToken());
                        yPos = Integer.parseInt(drawInfo.nextToken());

                        File arw  = new File(pointPath + "arrow_" + bun +".gif");
                        arwsrc  = JAI.create("fileload", arw.getPath());
                        arwImg  = arwsrc.getAsBufferedImage();

                        graphics.drawImage( arwImg , xPos, yPos,  null );

                    } else {
                        graphics.setFont(new Font("굴림체", 0, 12));

                        cmt = drawInfo.nextToken();
                        xPos = Integer.parseInt(drawInfo.nextToken());
                        yPos = Integer.parseInt(drawInfo.nextToken());

                        graphics.drawString(cmt, xPos, yPos);
                    }

                }

                try{
                    LConfiguration conf = LConfiguration.getInstance();
                    destFileName = conf.get("/devon/framework/front/upload/policy<default>/target-directory") + "/" + destFileName;
                }catch (Exception e) {
                    LLog.err.print(e);
                }

                File dest = new File(destFileName);
                ImageIO.write((RenderedImage) destImg, "jpg", dest);

            } catch ( Exception ex ) {
                ex.printStackTrace();
                System.out.println(ex.toString());
            }
        }


}


