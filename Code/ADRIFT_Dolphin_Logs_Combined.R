install.packages("writexl")

library(readxl)
library(dplyr)
library(writexl)

# Define file paths and sheet names
file_paths <- list.files(path = "C:/Users/sarah/OneDrive/Documents/GitHub/BIO-708/Code/ADRIFT_Dolphin_Logs", pattern = "\\.xlsx$", full.names = TRUE)
print(file_paths)
#sheet_names <- c("MetaData", "Detections", "AdhocDetections", "Effort", "References")
sheet_names <- c("Detections")

# Initialize a list to store combined data for each sheet
combined_data <- list()

# Loop over each sheet
for (sheet in sheet_names) {
  # Read each sheet across all files
  sheet_data <- lapply(file_paths, function(file) {
    # Attempt to read and print basic information about the data
    print(paste("Reading", sheet, "from", file))
    read_excel(file, sheet = sheet)
  })
  
  # Combine the data from all files for this specific sheet
  combined_data[[sheet]] <- bind_rows(sheet_data)
  
  # Print the first few rows to verify that data is being combined correctly
  print(paste("Combined data for", sheet))
  print(head(combined_data[[sheet]]))
}

# Write all combined sheets to a single Excel file
write_xlsx(combined_data, path = "combined_data_all_sheets.xlsx")
