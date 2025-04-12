<%@page contentType="text/html; charset=UTF-8"%> <%@ taglib prefix="c"
uri="http://java.sun.com/jsp/jstl/core" %> <%@ page isELIgnored="false" %>
<!DOCTYPE html>
<html lang="en">
  <head>
    <meta charset="UTF-8" />
    <meta http-equiv="X-UA-Compatible" content="IE=edge" />
    <meta name="viewport" content="width=device-width, initial-scale=1.0" />
    <title>Sign Up</title>
    <link rel="stylesheet" href="./assets/css/login.css" />
    <link rel="stylesheet" href="./assets/css/register.css" />
    <link
      rel="stylesheet"
      href="themify-icons-font/themify-icons/themify-icons.css"
    />
    <link
      rel="stylesheet"
      href="https://cdnjs.cloudflare.com/ajax/libs/font-awesome/5.15.3/css/all.min.css"
    />
    <link
      href="https://cdn.jsdelivr.net/npm/bootstrap@5.3.3/dist/css/bootstrap.min.css"
      rel="stylesheet"
      integrity="sha384-QWTKZyjpPEjISv5WaRU9OFeRpok6YctnYmDr5pNlyT2bRjXh0JMhjY6hW+ALEwIH"
      crossorigin="anonymous"
    />
    <script
      src="https://cdn.jsdelivr.net/npm/bootstrap@5.3.3/dist/js/bootstrap.bundle.min.js"
      integrity="sha384-YvpcrYf0tY3lHB60NNkmXc5s9fDVZLESaAA55NDzOxhy9GkcIdslK1eN7N6jIeHz"
      crossorigin="anonymous"
    ></script>
  </head>
  <body>
    <section class="vh-100">
      <div class="container-fluid">
        <div class="row">
          <div class="col-sm-4 text-black">
            <div class="px-5 ms-xl-4">
              <a style="text-decoration: none" href="/OrderingSystem">
                <span class="h1 fw-bold mb-0">FOODIE</span>
              </a>
            </div>

            <div
              class="d-flex align-items-center h-custom-2 px-5 ms-xl-4 mt-5 pt-5 pt-xl-0 mt-xl-n5"
            >
              <form action="register" method="post" style="width: 23rem">
                <h3 class="fw-normal mb-3 pb-3" style="letter-spacing: 1px">
                  Create an account
                </h3>

                <input type="hidden" name="action" value="register" />

                <div class="form-outline mb-4">
                  <input
                    type="text"
                    class="form-control form-control-lg"
                    placeholder="Full Name"
                    id="fullname"
                    name="fullname"
                    required
                  />
                </div>

                <div class="form-outline mb-4">
                  <input
                    type="text"
                    class="form-control form-control-lg"
                    placeholder="Username"
                    id="username"
                    name="username"
                    required
                  />
                </div>

                <div class="form-outline mb-4">
                  <input
                    type="password"
                    class="form-control form-control-lg"
                    placeholder="Password"
                    id="password"
                    name="password"
                    required
                  />
                </div>

                <div class="form-outline mb-4">
                  <input
                    type="text"
                    maxlength="10"
                    pattern="\d{10}"
                    class="form-control form-control-lg"
                    placeholder="Phone Number"
                    id="phonenumber"
                    name="phonenumber"
                    required
                  />
                </div>

                <div class="form-outline mb-4">
                  <input
                    type="email"
                    class="form-control form-control-lg"
                    placeholder="Email"
                    id="email"
                    name="email"
                    required
                  />
                </div>

                <div class="pt-1 mb-4">
                  <button class="btn btn-info btn-lg btn-block" type="submit">
                    Register
                  </button>
                  <a href="./register-restaurant"
                    ><button class="btn btn-block" type="button">
                      Restaurant Register
                    </button></a
                  >
                </div>

                <p class="text-danger text-center mt-3">${message}</p>
                <p style="text-align: center">
                  Already have an account?
                  <a href="./login" style="color: #5eae53" class=""
                    >Login here</a
                  >
                </p>
              </form>
            </div>
          </div>
          <div
            style="background-image: url(./assets/img/sliderback.svg)"
            class="col-sm-8 px-0 d-none d-sm-block"
          >
            <!--<img src="./img/banner.jpg" alt="Signup image" class="w-100 vh-100" style="object-fit: cover; object-position: left;">-->
          </div>
        </div>
      </div>
    </section>
    <script src="index.js"></script>
  </body>
</html>
