# importing required modules
from PyPDF2 import PdfReader

# creating a pdf reader object
reader = PdfReader('100_pytje.pdf')

# printing number of pages in pdf file
print(len(reader.pages))

# getting a specifi

# Get the number of pages in the PDF file
num_pages = len(reader.pages)

# Loop through all the pages in the PDF file

for i in range(num_pages):
    # Get the page
    page = reader.pages[i]

    # Get the text in the page
    text = page.extract_text()

print("DONE")
