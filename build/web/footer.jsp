<%@page contentType="text/html" pageEncoding="UTF-8"%>
<style>
    footer {
        background-color: #333;
        color: #fff;
        text-align: left;
        font-family: Arial, sans-serif;
        padding: 20px 0;
    }

    .footer-container {
        display: flex;
        justify-content: space-around;
        max-width: 1200px;
        margin: 0 auto;
    }

    .footer-section {
        flex: 1;
        padding: 0 20px; /* Thêm padding cho phần footer-section */
    }

    .footer-section h4 {
        margin-bottom: 15px;
        color: #fff; /* Màu chữ trắng */
    }

    .footer-section ul,
    .footer-section p,
    .footer-section a {
        list-style: none;
        padding: 0;
        margin: 0 0 10px;
        color: #ccc;
    }

    .footer-section a {
        text-decoration: none;
        color: #fff; /* Màu chữ trắng */
    }

    .footer-section a:hover {
        text-decoration: underline;
    }
    a {
        background-color: #323232;
    }
</style>

<footer>
  <div class="footer-container">
    <div class="footer-section">
        <h4>Shop VNG</h4>
        <ul>
            <li>Mang đến trải nghiệm tốt nhất cho khách hàng khi đến với Shop VNG</li>
        </ul>
      
    </div>
    <div class="footer-section">
      <h4>Liên hệ</h4>
      <ul>
        <li><a href="tel:+123456789">+84 898 495 157</a></li>
        <li><a href="mailto:support@xyzphones.com">ShopVNGsupport@gmail.com.com</a></li>
        <li>Long Thạnh Mỹ, Thành Phố Thủ Đức, Thành phố Hồ Chí Minh</li>
      </ul>
    </div>
    
    <div class="footer-section">
      <h4>Theo dõi chúng tôi</h4>
      <a href="https://www.facebook.com/profile.php?id=100028257765327">Facebook</a> | <a href="https://www.instagram.com/p_th_dim?igsh=bjBheng4aG9hYW5j">Instagram</a> | <a href="https://zalo.me/0342551806">Zalo</a>
    </div>
  </div>
</footer>