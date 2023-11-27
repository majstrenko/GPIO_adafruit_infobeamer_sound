gl.setup(NATIVE_WIDTH, NATIVE_HEIGHT)

util.no_globals()

local videos = {}

local current_video = nil
local video_playing = false

local function start_video(pin)
    stop_video()  -- Stop any currently playing video
    videos[pin] = resource.load_video{file = pin .. ".mp4", looped = false, audio = true, paused = true}
    current_video = videos[pin]
    current_video:start()
    video_playing = true
end

local function stop_video()
    if current_video then
        current_video:stop()
        current_video:dispose()  -- Dispose of the video object
        current_video = nil
    end
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
    if video_playing and current_video then
        local video_state, w, h = current_video:state()
        if video_state == "finished" then
            stop_video()
            gl.clear(1, 0, 0, 1)  -- Red, default state
        else
            current_video:draw(0, 0, WIDTH, HEIGHT)
        end
    else
        gl.clear(1, 0, 0, 1)  -- Red, default state
    end
end
