# Install required package if not already installed
if (!requireNamespace("tesseract", quietly = TRUE)) {
  install.packages("tesseract")
}

library(tesseract)

# Specify the image file path.
image_path <- "path_to_your_image.jpg"  # Replace with your image file path

# Load the Tesseract OCR engine
ocr_engine <- tesseract()

# Perform OCR on the image
text <- ocr(image_path, engine = ocr_engine)

# Print the extracted text
cat("Extracted Text:\n")
cat(text, "\n")

# Optional: Extract numbers from the text using regex
numbers <- gregexpr("\\d+", text)  # Find all numeric sequences
extracted_numbers <- regmatches(text, numbers)

cat("Extracted Numbers:\n")
print(unlist(extracted_numbers))

# Optional: Save the extracted text to a file
writeLines(text, "extracted_text.txt")

