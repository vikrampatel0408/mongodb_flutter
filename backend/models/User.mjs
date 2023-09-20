import mongoose from "mongoose";
import bcrypt from "bcrypt";
import jwt from "jsonwebtoken";

const userSchema = new mongoose.Schema({
    name: {
        type: String,
        required: [true, "name is require"],
    },
    email: {
        type: String,
        required: [true, "email is require"],
        unique: [true, "email exist"],
    },
    password: {
        type: String,
        required: [true, "password is require"],
        minlength: [6, "min 6 chars"],
        select: false,
    },
})

userSchema.pre("save", async function () {
    if (this.isModified("password")) {
        this.password = await bcrypt.hash(this.password, 10);
    }
})

userSchema.methods.matchPassword = async function (password) {
    return await bcrypt.compare(password, this.password)
}

userSchema.methods.generateToken = function () {
    return jwt.sign({ _id: this._id }, process.env.JWT_SECRET)
}

const User = mongoose.model("User", userSchema)

export default User;