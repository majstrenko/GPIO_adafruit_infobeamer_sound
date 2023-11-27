gl.setup(NATIVE_WIDTH, NATIVE_HEIGHT)

util.no_globals()

local videos = {
    [16] = {file = "1.mp4", video = nil},
    [17] = {file = "2.mp4", video = nil},
    [18] = {file = "3.mp4", video = nil},
    [19] = {file = "4.mp4", video = nil},
}

local current_video = nil
local video_playing = false

local function start_video(pin)
    stop_video() -- Stop any currently playing video
    current_video = videos[pin]
    current_video.video = resource.load_video{file = current_video.file, looped = false, audio = true, paused = true}
    current_video.video:start()
    video_playing = true
end

local function stop_video()
    if current_video and current_video.video then
        current_video.video:dispose()
        current_video.video = nil
    end
    current_video = nil
    video_playing = false
end

util.data_mapper{
    ["state/16"] = function(state)
        if state == '1' then
            start_video(16)
        elseif state == '0' then
            stop_video()
        end
    end,
    ["state/17"] = function(state)
        if state == '1' then
            start_video(17)
        elseif state == '0' then
            stop_video()
        end
    end,
    ["state/18"] = function(state)
        if state == '1' then
            start_video(18)
        elseif state == '0' then
            stop_video()
        end
    end,
    ["state/19"] = function(state)
        if state == '1' then
            start_video(19)
        elseif state == '0' then
            stop_video()
        end
    end,
}

function node.render()
    if video_playing and current_video and current_video.video then
        local video_state, w, h = current_video.video:state()
        if video_state == "finished" then
            stop_video()
            gl.clear(1, 0, 0, 1) -- red, default state
        else
            current_video.video:draw(0, 0, WIDTH, HEIGHT)
        end
    else
        gl.clear(1, 0, 0, 1) -- red, default state
    end
end
