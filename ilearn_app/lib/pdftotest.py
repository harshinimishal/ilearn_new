import fitz  # PyMuPDF

def extract_text_from_pdf(pdf_path):
    doc = fitz.open("chapter1.pdf")
    text = ""
    for page in doc:
        text += page.get_text("text") + "\n"
    return text

pdf_path = "science1_textbook.pdf"
text_data = extract_text_from_pdf(pdf_path)

with open("science1_text.txt", "w", encoding="utf-8") as file:
    file.write(text_data)
