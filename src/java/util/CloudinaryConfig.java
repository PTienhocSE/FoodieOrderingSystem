/*
 * Click nbfs://nbhost/SystemFileSystem/Templates/Licenses/license-default.txt to change this license
 * Click nbfs://nbhost/SystemFileSystem/Templates/Classes/Class.java to edit this template
 */
package util;

/**
 *
 * @author phuct
 */
import com.cloudinary.Cloudinary;
import com.cloudinary.utils.ObjectUtils;

public class CloudinaryConfig {

    private static Cloudinary cloudinary;

    static {
        cloudinary = new Cloudinary(ObjectUtils.asMap(
                "cloud_name", "dvyu4f7lq",
                "api_key", "197794349217857",
                "api_secret", "ZChTJNQesSSMQlZiw5VAusDuomA"
        ));
    }

    public static Cloudinary getCloudinary() {
        return cloudinary;
    }
}
