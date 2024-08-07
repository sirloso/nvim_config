local function build_rust_tests()
  print("Building Rust tests...")
  local build_pipe = io.popen('cargo test --no-run 2>&1')
  local build_result = build_pipe:read("*a")
  build_pipe:close()
  
  if build_result:match("error%:") then
    print("Cargo test build failed. Error output:")
    print(build_result)
    return false
  end
  
  print("Cargo test build completed successfully.")
  return true
end

local function run_last_test()
  local debug_dir = vim.fn.getcwd() .. '/target/debug/deps/'
  local handle = io.popen('ls -t ' .. debug_dir .. ' | grep -v "\\.d$"')
  local result = handle:read("*a")
  handle:close()

  local binaries = {}
  for binary in result:gmatch("[^\r\n]+") do
    -- Check if the file is executable and matches the test binary pattern
    -- if vim.fn.executable(debug_dir .. binary) == 1 and binary:match("^%w+%-[a-f0-9]+$") then
      table.insert(binaries, binary)
    -- end
  end

  return debug_dir .. binaries[1]
end

local function find_rust_test_binary(test_name)
  local debug_dir = vim.fn.getcwd() .. '/target/debug/deps/'
  local handle = io.popen('ls -t ' .. debug_dir .. ' | grep -v "\\.d$"')
  local result = handle:read("*a")
  handle:close()
  
  local binaries = {}
  for binary in result:gmatch("[^\r\n]+") do
    -- Check if the file is executable and matches the test binary pattern
    if vim.fn.executable(debug_dir .. binary) == 1 and binary:match("^%w+%-[a-f0-9]+$") then
      table.insert(binaries, binary)
    end
  end

  if #binaries > 0 then
    if test_name then
      -- If a test name is provided, search for a binary containing that name
      for _, binary in ipairs(binaries) do
        if binary:match(test_name) then
          return debug_dir .. binary
        end
      end
      print("No test binary found matching '" .. test_name .. "'")
      return nil
    else
      -- If no test name is provided, return the most recent binary
      return debug_dir .. binaries[1]
    end
  else
    print("No Rust test binaries found.")
    return nil
  end
end

local function build_and_find_rust_test_binary(test_name)
  if build_rust_tests() then
    local binary = find_rust_test_binary(test_name)
    if binary then
      return binary
    else
      local default_path = vim.fn.getcwd() .. '/target/debug/deps/'
      return vim.fn.input('Path to test executable: ', default_path, 'file')
    end
  else
    return nil
  end
end

return {
  build_rust_tests = build_rust_tests,
  find_rust_test_binary = find_rust_test_binary,
  build_and_find_rust_test_binary = build_and_find_rust_test_binary,
  run_last_test = run_last_test
}
