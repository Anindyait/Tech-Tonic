# Tech news website using Java Servlet, JSP, JDBC, MySQL and Tomcat.

<br />
<div align="center">
    <img src="TechTonic/src/main/webapp/imgs/tech.png" alt="Logo" width="100" height="100">
    <h3 align="center">TechTonic</h3>
    <p align="center">
        <!--PROJECT DESCRIPTION--!>
    </p>
</div>


## Preview

![dark mode](https://github.com/Anindyait/Tech-Tonic/assets/91337664/31fd984a-1e4c-4b10-88c6-1f969c7c5cc8)

![light mode](https://github.com/Anindyait/Tech-Tonic/assets/91337664/07bfbe4e-241b-45d9-83f5-bae2d9404452)

![dashboard](https://github.com/Anindyait/Tech-Tonic/assets/91337664/e94b5491-a0cf-496a-837f-86646d6d0348)

![login](https://github.com/Anindyait/Tech-Tonic/assets/91337664/0ae35997-8e02-4a77-ad9b-ca0c6091ed11)

![about](https://github.com/Anindyait/Tech-Tonic/assets/91337664/5078e3e3-a274-4120-a095-562425a97213)

https://github.com/Anindyait/Tech-Tonic/assets/91337664/dd59182c-69ae-4d0f-b40b-248726a17469



## Features

- User Registration and HTTP Cookie Based Login.
- Writing articles with title, image, tags and preview of it before posting.
- Edit/delete already written articles.
- Tag based sorting.
- Responsive design.
- Cookie based full website dark mode.
- Article progress bar.


## Requirements

Install the following as per your system's requirements:

- [Eclipse for Enterprise and Java Developers v2022-06](https://www.eclipse.org/downloads/packages/release/2022-06/r)
- [Tomcat v9.0](https://tomcat.apache.org/download-90.cgi)
- [MySQL v8.0](https://dev.mysql.com/downloads/installer/)


## Usage

1.  Clone the repo
   ```sh
   git clone https://github.com/Anindyait/Tech-Tonic
   ```

2. Create a MySQL database named **news** and update the DB password in the code _('abcd' by default)_ in the Utilities.java file. _Note_, this will only change the servlet passwords not the jsp ones, you have to deo it manually.

3. Create tables **article** and **user_table**.

4. Launch the project by running the **Index.java** file on Tomcat Server.

5. Create a user by registering. 

6. Login and write your articles.
