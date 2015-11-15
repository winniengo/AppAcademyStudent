DROP TABLE IF EXISTS users;
CREATE TABLE users (
  id INTEGER PRIMARY KEY,
  fname VARCHAR(255) NOT NULL,
  lname VARCHAR(255) NOT NULL
);

DROP TABLE IF EXISTS questions;
CREATE TABLE questions (
  id INTEGER PRIMARY KEY,
  title VARCHAR(255) NOT NULL,
  body VARCHAR(255) NOT NULL,
  user_id INTEGER,

  FOREIGN KEY(user_id) REFERENCES user(id)
);

DROP TABLE IF EXISTS question_follows;
CREATE TABLE question_follows (
  id INTEGER PRIMARY KEY,
  user_id INTEGER NOT NULL,
  question_id INTEGER NOT NULL,

  FOREIGN KEY(user_id) REFERENCES user(id),
  FOREIGN KEY(question_id) REFERENCES question(id)
);

DROP TABLE IF EXISTS replies;
CREATE TABLE replies (
  id INTEGER PRIMARY KEY,
  subject_question_id INTEGER NOT NULL,
  parent_reply_id INTEGER,
  user_id INTEGER NOT NULL,
  body VARCHAR(255) NOT NULL,

  FOREIGN KEY(subject_question_id) REFERENCES questions(id),
  FOREIGN KEY(parent_reply_id) REFERENCES replies(id),
  FOREIGN KEY(user_id) REFERENCES user(id)
);

DROP TABLE IF EXISTS question_likes;
CREATE TABLE question_likes (
  id INTEGER PRIMARY KEY,
  user_id INTEGER NOT NULL,
  question_id INTEGER NOT NULL,

  FOREIGN KEY(user_id) REFERENCES user(id),
  FOREIGN KEY(question_id) REFERENCES question(id)
);

INSERT INTO
  users(fname, lname)
VALUES
  ('Winnie', 'Ngo'),
  ('Tommy', 'Holmes'),
  ('Harry', 'Potter'),
  ('Albus', 'Dumbledore');

INSERT INTO
  questions(title, body, user_id)
VALUES
  ('SQL', 'How does it work?', (SELECT id FROM users WHERE fname = 'Winnie')),
  ('ORM', 'What does it stand for?', (SELECT id FROM users WHERE fname = 'Tommy')),
  ('a/A', 'Who does the odd person pair with?', (SELECT id FROM users WHERE fname = 'Tommy'));

INSERT INTO
  question_follows(user_id, question_id)
VALUES
  (1, 2),
  (2, 1),
  (3, 1),
  (3, 2);

INSERT INTO
  replies(subject_question_id, parent_reply_id, user_id, body)
VALUES
  (1, NULL, 2, 'this is how it works'),
  (1, 1, 1, 'not helpful'),
  (1, 2, 3, 'im harry potter');

INSERT INTO
  question_likes(user_id, question_id)
VALUES
  (2, 1),
  (3, 1),
  (3, 2),
  (3, 3),
  (4, 1),
  (4, 2),
  (1, 3),
  (1, 2);
