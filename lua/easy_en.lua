local function capture(cmd)
   local f = assert(io.popen(cmd, 'r'))
   local s = assert(f:read('*a'))
   f:close()
   return s
end

local function split_sentence(sentence)
   return capture([[python -c "import sys; import wordninja; sys.stdout.write(' '.join(wordninja.split(']] .. sentence .. [[')))"]])
end

local function enhance_filter(input, env)
   local cands = {}
   local is_split_sentence = env.engine.schema.config:get_bool('easy_en/split_sentence')

   for cand in input:iter() do
      if (cand.comment:find("☯")) then
         if (is_split_sentence) then
            sentence = split_sentence(cand.text)
            lower_sentence = string.lower(sentence)

            if (not (lower_sentence == sentence)) then
               yield(Candidate("sentence", cand.start, cand._end, lower_sentence .. " ", "💡"))
            end

            yield(Candidate("sentence", cand.start, cand._end, sentence .. " ", "💡"))
         end
      else
         yield(Candidate("word", cand.start, cand._end, cand.text .. " ", cand.comment))
      end
   end
end

return { enhance_filter = enhance_filter}
