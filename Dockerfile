# Use the official Bun image as a base
FROM oven/bun:latest as builder

# Set the working directory
WORKDIR /app

# Copy package.json and bun.lockb (if exists)
COPY package.json bun.lockb* ./

# Install dependencies
RUN bun install --frozen-lockfile

# Copy the rest of the application code
COPY . .

# Compile the application to a standalone executable
RUN bun build --compile index.ts --outfile app

# Use a slim base image for the final stage
FROM gcr.io/distroless/base-debian11

# Set the working directory
WORKDIR /app

# Copy the compiled executable from the builder stage
COPY --from=builder /app/app .

# Run the compiled executable
CMD ["./app"]


# # Use the official Bun image as a base
# FROM oven/bun:latest as builder

# # Set the working directory
# WORKDIR /app

# # Copy package.json and bun.lockb (if exists)
# COPY package.json bun.lockb* ./

# # Install dependencies
# RUN bun install --frozen-lockfile

# # Copy the rest of the application code
# COPY . .

# # Compile the application to a standalone executable
# RUN bun build index.ts --target=node --outfile=index.js

# # Use a slim base image for the final stage
# FROM gcr.io/distroless/nodejs22-debian12

# # Set the working directory
# WORKDIR /app

# # Copy the compiled executable from the builder stage
# COPY --from=builder /app/index.js .

# # Run the compiled executable
# CMD ["index.js"]
