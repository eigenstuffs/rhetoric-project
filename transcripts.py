from youtube_transcript_api import YouTubeTranscriptApi
from youtube_transcript_api.formatters import JSONFormatter

formatter = JSONFormatter()

video_ids = {
    "AL_2023": "oVf7VSt5plQ",
    "AK_2023": "MSBlPKkWnag",
    "AZ_2023": "OzNYDmlb9xE",
    "AR_2023": "BoOzvGw2RyI", # no speech until 2024, inauguration
    "CA_2023": "vXVyPLi2PwI", # newsom instead went on tour, inauguration
    "CO_2023": "buWsT-rOcN4",
    "CT_2023": "fjEsu2BzyME",
    "DE_2023": "DFfoWYFQS7Q",
    "FL_2023": "jEAaJArrgx0",
    "GA_2023": "zYOqtJqTJPY",
    "HI_2023": "SgWOLKbjqrc",
    "ID_2023": "Lw1JetFcOM4",
    "IL_2023": "CSYHtFb47CI",
    "IN_2023": "keQoiNpNMmQ",
    "IA_2023": "V6XJl-hIIvs", # condition of the state
    "KS_2023": "83FT-3irm9k",
    "KY_2023": "hUk8dYK5CSs", # state of the commonwealth
    "LA_2023": "yzj0SrQk_Dk",
    "ME_2023": "placeholder", # state of the budget?
    "MD_2023": "placeholder",
    "MA_2023": "placeholder",
    "MI_2023": "placeholder",
    "MN_2023": "placeholder",
    "MS_2023": "placeholder",
    "MO_2023": "placeholder",
    "MT_2023": "placeholder",
    "NE_2023": "placeholder",
    "NV_2023": "placeholder",
    "NH_2023": "placeholder",
    "NJ_2023": "placeholder",
    "NM_2023": "placeholder",
    "NY_2023": "placeholder",
    "NC_2023": "placeholder",
    "ND_2023": "placeholder",
    "OH_2023": "placeholder",
    "OK_2023": "placeholder",
    "OR_2023": "placeholder",
    "PA_2023": "placeholder",
    "RI_2023": "placeholder",
    "SC_2023": "placeholder",
    "SD_2023": "placeholder",
    "TN_2023": "placeholder",
    "TX_2023": "placeholder",
    "UT_2023": "placeholder",
    "VT_2023": "placeholder",
    "VA_2023": "placeholder",
    "WA_2023": "placeholder",
    "WV_2023": "placeholder",
    "WI_2023": "placeholder",
    "WY_2023": "placeholder"
}

for key, video_id in video_ids.items():
    try:
        transcript = YouTubeTranscriptApi.get_transcript(video_id)
        json_formatted = formatter.format_transcript(transcript)
        
        with open(f"{key}.json", "w") as file:
            file.write(json_formatted)
            
        print(f"Transcript for {key} saved as {key}.json")
        
    except Exception as e:
        print(f"Error retrieving transcript for {key}: {e}")
