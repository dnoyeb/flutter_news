import { NestFactory } from '@nestjs/core';
import { SwaggerModule, DocumentBuilder } from '@nestjs/swagger';
import { AppModule } from './app.module';
import { ResponseInterceptor } from './interceptor/response.interceptor';
import { HttpExceptionFilter } from './filter/http-exception.filter';
import { ValidationPipe } from './pipe/validation.pipe';

async function bootstrap() {
  const app = await NestFactory.create(AppModule);
  app.useGlobalInterceptors(new ResponseInterceptor())
  app.useGlobalFilters(new HttpExceptionFilter());
  app.useGlobalPipes(new ValidationPipe());

  const options = new DocumentBuilder()
    .setTitle('swagger案例')
    .setDescription('这是描述')
    .setVersion('1.0')
    .setTermsOfService('条款')
    .setContact('联系', '网址', '邮件')
    // .addServer('http://www.baidu.com', '域名代理')
    .addTag('addTag标签', '描述', {
      description: '描述1',
      url: 'http://www.hao123.com'
    })
    .addBearerAuth({
      type: 'http',
      description: '描述',
      name: '名字',
    })
    .build();
  const document = SwaggerModule.createDocument(app, options);
  SwaggerModule.setup('api', app, document);
  console.log('http://localhost:3000/api/')

  await app.listen(3000);
}
bootstrap();
