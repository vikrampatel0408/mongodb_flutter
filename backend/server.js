import app from "./app.mjs";
import connectDB from "./config/database.mjs";

connectDB();

app.listen(process.env.PORT, "0.0.0.0", () => {
  console.log(`Server running on port ${process.env.PORT}`);
});
