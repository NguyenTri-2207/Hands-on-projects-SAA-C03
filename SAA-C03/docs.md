1. 3-Tier Highly Available & Scalable Web Architecture
   Mục tiêu: Xây dựng một cấu trúc web 3 tầng có khả năng high availability (sẵn sàng cao) và fault tolerance (chống chịu lỗi).

Các dịch vụ AWS sử dụng: VPC, EC2, Application Load Balancer (ALB), Auto Scaling Group (ASG), Route 53, Amazon RDS (Multi-AZ).

Cách triển khai:

Thiết kế một Custom VPC với các public subnets và private subnets chia đều trên 2 Availability Zones (AZs).

Đặt ALB ở tầng public để tiếp nhận incoming traffic, cấu hình ASG ở tầng private để tự động scale up/down các EC2 instances dựa trên CPU utilization.

Triển khai database MySQL trên Amazon RDS với tính năng Multi-AZ deployment để đảm bảo dữ liệu luôn được replicated sang AZ khác phòng khi có sự cố.

Kiến thức thi SAA-C03 bổ trợ: Hiểu rõ cách thiết kế resilient architectures và cách hoạt động của load balancing cùng auto scaling.

2. Serverless Data Processing Pipeline
   Mục tiêu: Xây dựng một hệ thống xử lý dữ liệu tự động mà không cần quản lý hay provisioning server (Serverless).

Các dịch vụ AWS sử dụng: Amazon S3, AWS Lambda, Amazon DynamoDB, Amazon API Gateway, Amazon Cognito.

Cách triển khai:

Người dùng upload một file dữ liệu (ví dụ: CSV hoặc JSON) lên một S3 bucket.

Sự kiện upload này sẽ trigger một hàm AWS Lambda. Hàm Lambda này sẽ chịu trách nhiệm parse dữ liệu từ file và ghi trực tiếp vào DynamoDB table.

Tạo một REST API thông qua API Gateway được bảo mật bởi Amazon Cognito để cho phép ứng dụng frontend truy vấn dữ liệu từ DynamoDB.

Kiến thức thi SAA-C03 bổ trợ: Nắm vững xu hướng thiết kế Serverless architecture, cách tối ưu chi phí (cost-optimization) và tối ưu hiệu năng (high-performance).

3. Hybrid Cloud Storage & Data Migration Solution
   Mục tiêu: Giả lập một bài toán doanh nghiệp muốn migrate dữ liệu từ on-premises lên cloud và tối ưu hóa chi phí lưu trữ đường dài.

Các dịch vụ AWS sử dụng: AWS Storage Gateway (File Gateway), Amazon S3, S3 Lifecycle Policies, Amazon S3 Glacier.

Cách triển khai:

Cấu hình một Storage Gateway để kết nối môi trường local của bạn với Amazon S3, cho phép backup dữ liệu local lên cloud một cách mượt mà thông qua giao thức NFS/SMB.

Thiết lập S3 Lifecycle Policies để tự động hóa việc quản lý dữ liệu: Dữ liệu sau 30 ngày sẽ tự chuyển từ S3 Standard sang S3 Standard-IA (Infrequent Access) để tiết kiệm chi phí, và sau 90 ngày sẽ được archived vào Amazon S3 Glacier Flexible Retrieval hoặc Glacier Deep Archive.

Kiến thức thi SAA-C03 bổ trợ: Hiểu sâu về các S3 storage classes, cách chọn giải pháp lưu trữ tối ưu về chi phí và các phương án hybrid cloud storage.

4. Secure Multi-Tier Infrastructure with Centralized Monitoring
   Mục tiêu: Nâng cao tính bảo mật (security) và khả năng giám sát hệ thống cho một hạ tầng sẵn có.

Các dịch vụ AWS sử dụng: AWS IAM, AWS KMS, Amazon CloudWatch, AWS CloudTrail, Amazon GuardDuty.

Cách triển khai:

Áp dụng nguyên tắc Least Privilege bằng cách cấu hình IAM Policies chặt chẽ cho người dùng và các IAM Roles cho EC2/Lambda.

Sử dụng AWS KMS để tạo và quản lý customer managed keys, thực hiện encryption at rest cho toàn bộ S3 buckets và EBS volumes.

Kích hoạt AWS CloudTrail để audit mọi API calls trong account, cấu hình CloudWatch Alarms để gửi thông báo qua email (via SNS) khi phát hiện các hành vi bất thường hoặc khi CPU của EC2 vượt ngưỡng an toàn. Kích hoạt GuardDuty để tự động phát hiện các mối đe dọa thông minh.

Kiến thức thi SAA-C03 bổ trợ: Bao quát toàn bộ Domain 2 về Design Secure

5. Containerized Web Application with ECS & Fargate
   Mục tiêu: Triển khai một ứng dụng web dạng microservices chạy trên container mà không cần quản lý hay provision các EC2 instances (Serverless Container).

Các dịch vụ AWS sử dụng: Amazon Elastic Container Service (ECS), AWS Fargate, Amazon Elastic Container Registry (ECR), Application Load Balancer (ALB).

Cách triển khai:

Dockerize một ứng dụng web nhỏ ở local, sau đó push image đó lên một repository bảo mật trên Amazon ECR.

Tạo một ECS Cluster sử dụng Fargate launch type để AWS tự động quản lý phần hạ tầng tính toán bên dưới.

Định nghĩa Task Definitions và Services, cấu hình ALB để định tuyến traffic đến các container đang chạy. Thiết lập Health checks để hệ thống tự động thay thế container bị lỗi.

Kiến thức thi SAA-C03 bổ trợ: Nắm chắc mảng Container orchestration trên AWS, phân biệt rõ giữa ECS EC2 launch type và AWS Fargate, giúp bạn giải quyết các câu hỏi về tối ưu vận hành (operational excellence).

6. Global Content Delivery & High Performance Web
   Mục tiêu: Tăng tốc độ truy cập cho một website toàn cầu và giảm tải cho hệ thống gốc (origin server).

Các dịch vụ AWS sử dụng: Amazon CloudFront, Amazon S3, Route 53, AWS Certificate Manager (ACM), AWS WAF.

Cách triển khai:

Lưu trữ các static assets (hình ảnh, CSS, JS) của website trong một S3 bucket.

Cấu hình một CloudFront Distribution làm CDN để cache nội dung tại các Edge Locations trên toàn thế giới, giúp người dùng truy cập với low latency.

Sử dụng Origin Access Control (OAC) để đảm bảo người dùng chỉ có thể truy cập file thông qua CloudFront chứ không thể truy cập trực tiếp vào S3 bucket. Tích hợp AWS WAF để chặn các cuộc tấn công web phổ biến (như SQL Injection, DDoS).

Kiến thức thi SAA-C03 bổ trợ: Hiểu sâu về cơ chế caching, bảo mật tầng biên (edge security), và cách thiết kế hệ thống có hiệu năng cao (high-performance architectures).

7. Event-Driven Microservices Architecture
   Mục tiêu: Thiết kế hệ thống xử lý đơn hàng theo kiến trúc hướng sự kiện (event-driven), giúp các dịch vụ được decoupled (tách biệt) hoàn toàn.

Các dịch vụ AWS sử dụng: Amazon SNS, Amazon SQS, AWS Lambda, Amazon EventBridge.

Cách triển khai:

Khi khách hàng đặt hàng thành công, một sự kiện sẽ được gửi đến một SNS Topic (Fan-out pattern).

Từ SNS Topic này, message sẽ được phân phối đến nhiều SQS queues khác nhau phục vụ cho các mục đích riêng biệt: một queue cho dịch vụ thanh toán, một queue cho dịch vụ gửi email xác nhận, và một queue cho hệ thống quản lý kho (inventory).

Các hàm Lambda riêng lẻ sẽ poll tin nhắn từ các queue này để xử lý asynchronously (bất đồng bộ), đảm bảo nếu một dịch vụ bị lỗi thì không ảnh hưởng đến toàn bộ hệ thống.

Kiến thức thi SAA-C03 bổ trợ: Đây là bài toán kinh điển về decoupling applications xuất hiện rất nhiều trong bài thi.

8. Database Caching for Read-Heavy Applications
   Mục tiêu: Tối ưu hóa hiệu năng và giảm read latency cho một hệ thống ứng dụng có lượng người đọc dữ liệu cực kỳ lớn.

Các dịch vụ AWS sử dụng: Amazon RDS, Amazon ElastiCache (Redis hoặc Memcached), Amazon EC2.

Cách triển khai:

Triển khai một ứng dụng web chạy trên EC2 kết nối với một RDS MySQL database.

Cấu hình một cụm ElastiCache (Redis) đứng trước RDS làm tầng caching layer.

Viết code ứng dụng theo mô hình Lazy Loading (hoặc Cache-Aside): Khi có yêu cầu đọc dữ liệu, ứng dụng sẽ check trong ElastiCache trước. Nếu cache hit, trả kết quả ngay; nếu cache miss, ứng dụng sẽ query từ RDS, trả về cho người dùng rồi lưu ngược lại vào ElastiCache để phục vụ cho lần sau.

Kiến thức thi SAA-C03 bổ trợ: Nắm rõ cách tối ưu hóa tầng database, phân biệt khi nào dùng DynamoDB Accelerator (DAX) vs ElastiCache vs RDS Read Replicas trong bài thi.

9. Cross-Region Disaster Recovery (DR) Architecture
   Mục tiêu: Thiết kế phương án khắc phục sự cố nghiêm trọng bằng cách thiết lập hệ thống DR sẵn sàng kích hoạt ở một AWS Region hoàn toàn khác.

Các dịch vụ AWS sử dụng: Amazon Route 53 (Failover Routing), Amazon RDS (Cross-Region Read Replicas), Amazon S3 (Cross-Region Replication - CRR).

Cách triển khai:

Thiết lập hạ tầng chính tại Region A (Primary) và hạ tầng dự phòng tại Region B (Secondary).

Bật tính năng Cross-Region Replication cho S3 bucket và tạo Cross-Region Read Replica cho RDS từ Region A sang Region B.

Cấu hình Route 53 Failover Routing Policy kèm theo Health Checks. Khi hệ thống ở Region A gặp sự cố (unhealthy), Route 53 sẽ tự động chuyển hướng toàn bộ domain traffic sang Region B. Tại Region B, bạn thực hiện promote RDS Read Replica thành Primary Database để ứng dụng tiếp tục chạy.

Kiến thức thi SAA-C03 bổ trợ: Đây là trọng tâm của phần Reliability domain. Bạn cần hiểu rõ các chiến lược DR (Backup & Restore, Pilot Light, Warm Standby, Multi-Site) và các chỉ số RPO/RTO.

10. Centralized Log Analytics & Search Engine
    Mục tiêu: Thu thập, lưu trữ và phân tích log từ nhiều nguồn tập trung về một nơi để phục vụ cho việc troubleshooting và giám sát hệ thống.

Các dịch vụ AWS sử dụng: Amazon EC2, Amazon CloudWatch Logs, Amazon Kinesis Data Firehose, Amazon OpenSearch Service (tiền thân là Elasticsearch).

Cách triển khai:

Cài đặt CloudWatch Logs Agent trên các EC2 instances để tự động đẩy các file log hệ thống (application log, access log) lên CloudWatch Logs Groups.

Cấu hình Subscription Filters trên CloudWatch Logs để stream dữ liệu log này theo thời gian thực (real-time) qua Amazon Kinesis Data Firehose.

Kinesis Data Firehose sẽ chịu trách nhiệm chuyển hóa và nạp dữ liệu log trực tiếp vào Amazon OpenSearch Service, nơi bạn có thể dùng dashboard để tìm kiếm, phân tích và trực quan hóa lỗi của hệ thống.

Kiến thức thi SAA-C03 bổ trợ: Giúp bạn làm quen với hệ sinh thái xử lý dữ liệu lớn (Big Data & Analytics) và các phương án real-time streaming thường gặp trong bài thi SAA.

📅 Gợi ý Plan 1 tháng ôn luyện (30 ngày)
Tuần 1 (Dự án 1, 2, 3): Tập trung vào Core Infrastructure (VPC, Compute, Serverless, Auto Scaling).

Tuần 2 (Dự án 4, 5, 8): Tập trung vào Storage, Database, Caching và Security/IAM/KMS.

Tuần 3 (Dự án 6, 7, 9, 10): Tập trung vào Advanced Architectures (Containers, Global CDN, DR, Data Streaming).

Tuần 4 (Luyện Đề Toàn Thời Gian): Làm liên tục ít nhất 4-5 bộ Practice Exams đầy đủ (65 câu/130 phút) từ các nguồn uy tín (như Tutorial Dojo hoặc Stephane Maarek) để rèn tâm lý và kỹ năng quản lý thời gian.
