import { NestFactory } from '@nestjs/core';
import { AppModule } from './app.module';
import { ValidationPipe } from '@nestjs/common/pipes';
import * as session from 'express-session';

async function bootstrap() {
  const app = await NestFactory.create(AppModule);
  app.useGlobalPipes(new ValidationPipe());
  app.use(
    session({
      name: 'NESTJS_SESSION',
      secret: 'oof',
      resave: false,
      saveUninitialized: true,
      cookie: {
        maxAge: 3600000,
      },
    }),
  );
  await app.listen(3000);
}
bootstrap();
