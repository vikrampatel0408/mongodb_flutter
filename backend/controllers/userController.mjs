import User from "../models/User.mjs";

const register = async (req, res) => {
  console.log("In signup");
  try {
    const { name, email, password } = req.body;
    console.log("In the register");

    // check the user exist or not
    let user = await User.findOne({ email });
    if (user)
      return res.status(500).json({
        success: false,
        msg: "User is already exist",
      });

    // create new user
    user = await User.create({ name, email, password });

    // generate token
    const token = await user.generateToken();

    // give success response
    res
      .status(200)
      .cookie("token", token, {
        expires: new Date(Date.now() + 1 * 24 * 60 * 60 * 1000),
        httpOnly: true,
      })
      .json({
        success: true,
        user,
        token,
      });
  } catch (error) {
    // give error response
    res.status(500).json({
      success: false,
      message: error.message,
    });
  }
};

const login = async (req, res) => {
  try {
    const { email, password } = req.body;

    if (!email || !password)
      res.status(500).json({
        success: false,
        message: "Enter Credentials",
      });

    const user = await User.findOne({ email }).select("+password");
    if (!user)
      return res.status(500).json({
        success: false,
        message: "User not found",
      });

    const isMatch = await user.matchPassword(password);

    if (!isMatch) {
      return res.status(500).json({
        success: false,
        message: "Invalid Credentials",
      });
    }

    const token = await user.generateToken();

    res
      .status(200)
      .cookie("token", token, {
        expires: new Date(Date.now() + 1 * 24 * 60 * 60 * 1000),
        httpOnly: true,
      })
      .json({
        success: true,
        user,
        token,
      });
  } catch (error) {
    res.status(500).json({
      success: false,
      message: error.message,
    });
  }
};

const logout = async (req, res) => {
  try {
    res
      .status(200)
      .cookie("token", null, {
        expires: new Date(Date.now()),
        httpOnly: true,
      })
      .json({
        success: true,
        message: "logout success",
      });
  } catch (error) {
    res.status(500).json({
      success: false,
      message: error.message,
    });
  }
};

export { register, login, logout };
