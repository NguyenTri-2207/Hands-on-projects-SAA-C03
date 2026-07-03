2 Dự Án AI Agent Tự Động Hóa UI & CRM Trên AWS
Dự án 1: AI-Driven CRM Automation (Tự động hóa CRM nội bộ qua hội thoại)

Full-stack core: Viết giao diện Chat (React/Next.js) kết hợp với một trang CRM giả lập đơn giản do bạn tự code (có màn hình Login, Form điền thông tin).

AI Agent & AWS: Sử dụng Amazon Bedrock (Claude Sonnet 5) để làm bộ não nhận diện câu lệnh tiếng Việt và tự xuất ra kế hoạch hành động dạng JSON. Sử dụng AWS Lambda + Playwright (Docker) để mở trình duyệt ngầm, lấy thông tin tài khoản từ AWS Secrets Manager rồi tự động điền form/click chuột trên trang CRM giả lập đó. Bạn cũng rèn luyện khả năng gửi ảnh chụp màn hình (Computer Vision) ngược lại cho Bedrock để AI tự "nhìn" giao diện và sửa lỗi click.

Dự án 2: Autonomous E-Commerce Deal Hunter Agent (AI tự động săn deal và đặt hàng)

Full-stack core: Xây dựng Dashboard quản lý các chiến dịch săn deal. Backend lưu trữ trạng thái và hiển thị live timeline từng hành động mà AI đang làm ngoài trình duyệt.

AI Agent & AWS: Chuyển sang dùng AWS Fargate (Amazon ECS) để duy trì các container chạy trình duyệt ngầm dài hạn (do săn deal mất nhiều thời gian hơn, Lambda sẽ bị timeout). Kết hợp với AWS Step Functions để điều phối quy trình (Tìm kiếm ➔ Chọn hàng ➔ Điền địa chỉ ➔ Đặt mua). Sử dụng Amazon SNS để gửi cảnh báo khẩn cấp về điện thoại/email (Human-in-the-loop) khi gặp các ca khó như CAPTCHA, và lưu trữ log/hình ảnh tại DynamoDB & S3.

💡 Lời khuyên khi triển khai trong 1 tháng:
Nửa đầu tháng: Tập trung làm phần khung Full-stack (Frontend/Backend) và code công cụ click tự động (Playwright/Puppeteer) chạy ở local trước. Lúc này, bạn song song ôn tập các kiến thức cốt lõi của bài thi SAA-C03 như EC2, VPC, Lambda, Storage (S3).

Nửa cuối tháng: Bắt đầu đưa AI từ Amazon Bedrock vào để thay thế các đoạn code fix cứng (hard-coded), nâng cấp hệ thống lên AWS Fargate và Step Functions. Đây cũng là thời điểm bạn học các kiến thức nâng cao về High Availability, Security, và State Machine của AWS để chuẩn bị đi thi.

Sau khi hoàn thành và pass chứng chỉ SAA-C03, các dự án này sẽ là điểm cộng cực kỳ lớn trong CV, chứng minh bạn vừa hiểu sâu kiến thức Cloud truyền thống, vừa có năng lực phát triển các sản phẩm AI Agent tiên tiến nhất hiện nay!
