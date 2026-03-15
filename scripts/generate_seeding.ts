import { writeFileSync, readFileSync } from "node:fs";

interface SeedData {
  categories: string[];
  publisher: string[];
  author: string[];
  books: any[];
  staffs: any[];
  member_cards: any[];
  members: any[];
  book_author: any[];
}

const prepend = `USE [LMS]\nGO`;

const rawData = readFileSync("assets/data/seed.json", "utf-8");
const data: SeedData = JSON.parse(rawData);

let sql = `${prepend}\n\n`;

const escapeN = (val: any) =>
  typeof val === "string" ? `N'${val.replace(/'/g, "''")}'` : val;
const escapeS = (val: any) =>
  typeof val === "string" ? `'${val.replace(/'/g, "''")}'` : val;

// --- 1. Categories ---
sql += `INSERT INTO Category(name) VALUES\n`;
sql +=
  data.categories.map((name) => `(${escapeN(name)})`).join(",\n") + `\nGO\n\n`;

// --- 2. Publishers ---
sql += `INSERT INTO Publisher(name) VALUES\n`;
sql +=
  data.publisher.map((name) => `(${escapeN(name)})`).join(",\n") + `\nGO\n\n`;

// --- 3. Authors ---
sql += `INSERT INTO Author(name) VALUES\n`;
sql += data.author.map((name) => `(${escapeN(name)})`).join(",\n") + `\nGO\n\n`;

// --- 4. Books ---
sql += `INSERT INTO Book(ISBN, title, category_id, description, language, publisher_id) VALUES\n`;
sql +=
  data.books
    .map(
      (b) =>
        `(${escapeS(b.ISBN)}, ${escapeN(b.title)}, ${b.category_id}, ${escapeN(b.description)}, '${b.language}', ${b.publisher_id})`,
    )
    .join(",\n") + `\nGO\n\n`;

// --- 5. BookAuthor ---
sql += `INSERT INTO BookAuthor(book_id, author_id, is_primary) VALUES\n`;
sql +=
  data.book_author
    .map((ba) => `(${ba.book_id}, ${ba.author_id}, ${ba.is_primary})`)
    .join(",\n") + `\nGO\n\n`;

// --- 6. BookItem ---
sql += `INSERT INTO BookItem(book_id, barcode, status, shelf_position) VALUES\n`;
sql +=
  data.books
    .map((_, index) => {
      const bookId = index + 1;
      const barcode = `BC${bookId.toString().padStart(3, "0")}`;
      return `(${bookId}, '${barcode}', 'Available', 'A${bookId.toString().padStart(2, "0")}')`;
    })
    .join(",\n") + `\nGO\n\n`;

// --- 7. Staff ---
sql += `INSERT INTO Staff(name, phone) VALUES\n`;
sql +=
  data.staffs.map((s) => `(${escapeN(s.name)}, '${s.phone}')`).join(",\n") +
  `\nGO\n\n`;

// --- 8. MemberCard ---
sql += `INSERT INTO MemberCard(card_number, expiry, status) VALUES\n`;
sql +=
  data.member_cards
    .map((mc) => `('${mc.card_number}', '${mc.expiry}', 'Active')`)
    .join(",\n") + `\nGO\n\n`;

// --- 9. Member ---
sql += `INSERT INTO Member(phone, name, email, address, card_number) VALUES\n`;
sql +=
  data.members
    .map(
      (m) =>
        `('${m.phone}', ${escapeN(m.name)}, '${m.email}', ${escapeN(m.address)}, '${m.card_number}')`,
    )
    .join(",\n") + `\nGO\n\n`;

writeFileSync("sql/Seeding.sql", sql);
console.log("OK");
