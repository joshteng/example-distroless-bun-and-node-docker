async function sleep(ms: number) {
  await new Promise((resolve) => setTimeout(resolve, ms));
}

async function main() {
  while (true) {
    console.log("Hello via Bun!");
    await sleep(5_000);
  }
}

main();
