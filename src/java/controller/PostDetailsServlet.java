/*
 * Click nbfs://nbhost/SystemFileSystem/Templates/Licenses/license-default.txt to change this license
 * Click nbfs://nbhost/SystemFileSystem/Templates/JSP_Servlet/Servlet.java to edit this template
 */
package controller;

import com.cloudinary.Cloudinary;
import com.cloudinary.utils.ObjectUtils;
import context.AccountDAO;
import context.CommentDAO;
import context.PostDAO;
import jakarta.servlet.ServletConfig;
import jakarta.servlet.ServletException;
import jakarta.servlet.annotation.MultipartConfig;
import jakarta.servlet.annotation.WebServlet;
import jakarta.servlet.http.HttpServlet;
import jakarta.servlet.http.HttpServletRequest;
import jakarta.servlet.http.HttpServletResponse;
import jakarta.servlet.http.Part;
import java.io.File;
import java.io.IOException;
import java.io.InputStream;
import java.io.PrintWriter;
import java.nio.file.Paths;
import java.util.Date;
import java.util.List;
import java.util.Map;
import model.Comment;
import model.Post;

/**
 *
 * @author phuct
 */
@WebServlet(name = "PostDetailsServlet", urlPatterns = {"/postDetails"})
@MultipartConfig(fileSizeThreshold = 1024 * 1024 * 2, // 2MB
        maxFileSize = 1024 * 1024 * 10, // 10MB
        maxRequestSize = 1024 * 1024 * 50)   // 50MB
public class PostDetailsServlet extends HttpServlet {

    private PostDAO postDAO = new PostDAO();
    private CommentDAO commentDAO = new CommentDAO();
    private AccountDAO accountDAO = new AccountDAO();
    private static final String SAVE_DIR = "blogImg";

    private Cloudinary cloudinary;

    @Override
    public void init(ServletConfig config) throws ServletException {
        cloudinary = new Cloudinary(ObjectUtils.asMap(
                "cloud_name", "dvyu4f7lq",
                "api_key", "197794349217857",
                "api_secret", "ZChTJNQesSSMQlZiw5VAusDuomA"));
    }

    @Override
    protected void doGet(HttpServletRequest request, HttpServletResponse response)
            throws ServletException, IOException {
        try {
            String postIdParam = request.getParameter("postID");
            if (postIdParam != null) {
                int postId = Integer.parseInt(postIdParam);
                Post post = postDAO.getPostById(postId);

                if (post != null) {
                    String fullName = postDAO.getFullNameByPostId(postId);
                    String avtURL = postDAO.getAvatarByPostId(postId);

                    request.setAttribute("postID", postIdParam);
                    request.setAttribute("post", post);
                    request.setAttribute("fullName", fullName);
                    request.setAttribute("avtURL", avtURL);

                    List<Comment> comments = commentDAO.getCommentsByPostID(postId);
                    request.setAttribute("comments", comments);

                    request.getRequestDispatcher("/WEB-INF/view/blogdetails.jsp").forward(request, response);
                } else {
                    response.sendError(HttpServletResponse.SC_NOT_FOUND);
                }
            } else {
                response.sendError(HttpServletResponse.SC_BAD_REQUEST);
            }
        } catch (NumberFormatException e) {
            response.sendError(HttpServletResponse.SC_BAD_REQUEST);
        } catch (Exception e) {
            e.printStackTrace();
            response.sendError(HttpServletResponse.SC_INTERNAL_SERVER_ERROR);
        }
    }

    @Override
    protected void doPost(HttpServletRequest request, HttpServletResponse response)
            throws ServletException, IOException {
        String action = request.getParameter("action");

        // Null check for the action parameter
        if (action == null) {
            response.sendError(HttpServletResponse.SC_BAD_REQUEST, "Action parameter is missing");
            return;
        }

        switch (action) {
            case "addComment":
                handleAddComment(request, response);
                break;
            case "editComment":
                handleEditComment(request, response);
                break;
            case "deleteComment":
                handleDeleteComment(request, response);
                break;
            case "addPost":
                handleAddPost(request, response);
                break;
            case "editPost":
                handleEditPost(request, response);
                break;
            case "deletePost":
                handleDeletePost(request, response);
                break;
            default:
                response.sendError(HttpServletResponse.SC_BAD_REQUEST, "Invalid action");
        }
    }

    private void handleAddComment(HttpServletRequest request, HttpServletResponse response)
            throws ServletException, IOException {
        try {
            String commentText = request.getParameter("commentInput");
            String postIdParam = request.getParameter("postID");
            String userIdParam = request.getParameter("userID");

            if (postIdParam == null || userIdParam == null) {
                response.sendError(HttpServletResponse.SC_BAD_REQUEST, "Missing post or user ID");
                return;
            }

            int postId = Integer.parseInt(postIdParam);
            int userID = Integer.parseInt(userIdParam);
            String userFullName = accountDAO.getFullNameByUserId(userID);
            String userAvtURL = accountDAO.getAvatarByUserId(userID);

            Comment comment = new Comment(userID, userFullName, userAvtURL, postId, commentText);
            comment.setCreatedDate(new Date());
            boolean isAdded = commentDAO.addComment(comment);

            if (isAdded) {
                int postID = Integer.parseInt(request.getParameter("postID"));
                response.sendRedirect("postDetails?postID=" + postID);
            } else {
                request.setAttribute("error", "Failed to post comment. Please try again.");
                request.getRequestDispatcher("/WEB-INF/view/blogdetails.jsp").forward(request, response);
            }
        } catch (Exception e) {
            e.printStackTrace();
            response.sendRedirect(request.getContextPath() + "/blog");
        }
    }

    private void handleEditComment(HttpServletRequest request, HttpServletResponse response)
            throws ServletException, IOException {
        try {
            int commentID = Integer.parseInt(request.getParameter("commentID"));
            String commentContent = request.getParameter("commentContent");

            boolean updated = commentDAO.updateComment(commentID, commentContent);
            int postID = Integer.parseInt(request.getParameter("postID"));

            if (updated) {
                response.sendRedirect("postDetails?postID=" + postID);
            } else {
                request.setAttribute("error", "Error updating comment.");
                request.getRequestDispatcher("/WEB-INF/view/blogdetails.jsp").forward(request, response);
            }
        } catch (Exception ex) {
            ex.printStackTrace();
            response.sendError(HttpServletResponse.SC_INTERNAL_SERVER_ERROR);
        }
    }

    private void handleDeleteComment(HttpServletRequest request, HttpServletResponse response)
            throws ServletException, IOException {
        try {
            int commentId = Integer.parseInt(request.getParameter("commentID"));
            boolean success = commentDAO.deleteComment(commentId);
            int postID = Integer.parseInt(request.getParameter("postID"));

            if (success) {
                response.sendRedirect("postDetails?postID=" + postID);
            } else {
                request.setAttribute("error", "Failed to delete the comment.");
                request.getRequestDispatcher("/WEB-INF/view/blogdetails.jsp").forward(request, response);
            }
        } catch (Exception e) {
            e.printStackTrace();
            response.sendError(HttpServletResponse.SC_INTERNAL_SERVER_ERROR);
        }
    }

    //HANDEL POST
    private void handleAddPost(HttpServletRequest request, HttpServletResponse response)
            throws ServletException, IOException {
        try {
            String title = request.getParameter("title");
            String description = request.getParameter("description");
            String userIdParam = request.getParameter("userID");
            Part filePart = request.getPart("imgPost");

            if (title == null || description == null || userIdParam == null || filePart == null) {
                response.sendError(HttpServletResponse.SC_BAD_REQUEST, "Missing required fields");
                return;
            }

            int userID = Integer.parseInt(userIdParam);

            if (filePart != null && filePart.getSize() > 0) {
                InputStream fileStream = filePart.getInputStream();
                byte[] fileBytes = fileStream.readAllBytes();

                Map uploadResult = cloudinary.uploader().upload(fileBytes, ObjectUtils.emptyMap());

                String imageUrl = (String) uploadResult.get("url");

                Post newPost = new Post();
                newPost.setUserID(userID);
                newPost.setImgURL(imageUrl); // Use the Cloudinary URL
                newPost.setHeading(title);
                newPost.setContent(description);

                PostDAO postDAO = new PostDAO();
                boolean isAdded = postDAO.createPost(newPost);

                if (isAdded) {
                    response.sendRedirect("blog");
                } else {
                    request.setAttribute("error", "Failed to add post. Please try again.");
                    request.getRequestDispatcher("/WEB-INF/view/addPost.jsp").forward(request, response);
                }
            } else {
                response.sendError(HttpServletResponse.SC_BAD_REQUEST, "Image file is required.");
            }
        } catch (Exception e) {
            e.printStackTrace();
            request.setAttribute("error", "An error occurred while processing your request.");
            request.getRequestDispatcher("/WEB-INF/view/addPost.jsp").forward(request, response);
        }
    }

    private void handleDeletePost(HttpServletRequest request, HttpServletResponse response)
            throws ServletException, IOException {
        try {
            String postIdParam = request.getParameter("postID");

            if (postIdParam == null) {
                response.sendError(HttpServletResponse.SC_BAD_REQUEST, "Missing post ID");
                return;
            }

            int postID = Integer.parseInt(postIdParam);

            PostDAO postDAO = new PostDAO();
            boolean success = postDAO.deletePost(postID);

            if (success) {
                response.sendRedirect("blog");
            } else {
                request.setAttribute("error", "Failed to delete the post. Please try again.");
                request.getRequestDispatcher("/WEB-INF/view/blog.jsp").forward(request, response);
            }
        } catch (Exception e) {
            e.printStackTrace();
            request.setAttribute("error", "An error occurred while processing your request.");
            request.getRequestDispatcher("/WEB-INF/view/blog.jsp").forward(request, response);
        }
    }

   private void handleEditPost(HttpServletRequest request, HttpServletResponse response)
        throws ServletException, IOException {
    try {
        Part filePart = request.getPart("imgPost");
        String title = request.getParameter("title");
        String description = request.getParameter("description");
        String postIdParam = request.getParameter("postID");
        String userIdParam = request.getParameter("userID");

        if (postIdParam == null || userIdParam == null || title == null || description == null) {
            response.sendError(HttpServletResponse.SC_BAD_REQUEST, "Missing post or user ID or other required fields");
            return;
        }

        int postId = Integer.parseInt(postIdParam);
        int userId = Integer.parseInt(userIdParam);

        Post updatedPost = new Post();
        updatedPost.setPostID(postId);
        updatedPost.setUserID(userId);
        updatedPost.setHeading(title);
        updatedPost.setContent(description);

        if (filePart != null && filePart.getSize() > 0) {
            InputStream fileStream = filePart.getInputStream();
            byte[] fileBytes = fileStream.readAllBytes();

            Map uploadResult = cloudinary.uploader().upload(fileBytes, ObjectUtils.emptyMap());

            String imageUrl = (String) uploadResult.get("url");

            updatedPost.setImgURL(imageUrl);
        }

        PostDAO postDAO = new PostDAO();
        boolean success = postDAO.updatePost(updatedPost);

        if (success) {
            response.sendRedirect("postDetails?postID=" + postId);
        } else {
            request.setAttribute("error", "Failed to update the post.");
            request.getRequestDispatcher("/WEB-INF/view/blog.jsp").forward(request, response);
        }
    } catch (Exception e) {
        e.printStackTrace();
        request.setAttribute("error", "An error occurred while processing your request.");
        request.getRequestDispatcher("/WEB-INF/view/blog.jsp").forward(request, response);
    }
}


    @Override
    public String getServletInfo() {
        return "Handles blog details and comments";
    }
}
