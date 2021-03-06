package
{
    import org.flixel.*;

    public class Arm
    {
        [Embed(source="../assets/girl_forearm.png")] private var ImgForearm:Class;
        [Embed(source="../assets/girl_handL.png")] private var ImgHandL:Class;
        [Embed(source="../assets/girl_handR.png")] private var ImgHandR:Class;
        [Embed(source="../assets/girl_fingersL.png")] private var ImgFingersL:Class;
        [Embed(source="../assets/girl_fingersR.png")] private var ImgFingersR:Class;

        public var m_physScale:Number = 30

        public var forearm:FlxSprite;
        public var hand:FlxSprite;
        public var fingers:FlxSprite;

        public var heldDoll:DollGrabber;
        public var armBase:FlxPoint;

        public var debugText:FlxText;

        public function Arm(x:Number, doll:DollGrabber, rt:Boolean = false)
        {
            debugText = new FlxText(0, 30, FlxG.width, "");
            if (rt) {
                FlxG.state.add(debugText);
            }

            this.heldDoll = doll;

            forearm = new FlxSprite(x, 180);
            forearm.loadGraphic(ImgForearm, true, true, 81, 524, true);
            FlxG.state.add(forearm);

            hand = new FlxSprite(x, 120);
            if (rt) {
                hand.loadGraphic(ImgHandL, true, true, 88, 89, true);
            } else {
                hand.loadGraphic(ImgHandR, true, true, 88, 89, true);
            }
            FlxG.state.add(hand);

            fingers = new FlxSprite(x, 120);
            if (rt) {
                fingers.loadGraphic(ImgFingersL, true, true, 88, 89, true);
            } else {
                fingers.loadGraphic(ImgFingersR, true, true, 88, 89, true);
            }
            FlxG.state.add(fingers);

            this.armBase = new FlxPoint(forearm.x + forearm.width/2,
                                        forearm.y + forearm.height/2);
        }

        public function turn(clockwise:Boolean):void
        {
            var turnAmt:Number = 10;
            if (clockwise) {
                hand.angle = turnAmt;
                fingers.angle = turnAmt;
            } else {
                hand.angle = -turnAmt;
                fingers.angle = -turnAmt;
            }
        }

        public function stopTurning():void
        {
            hand.angle = 0;
            fingers.angle = 0;
        }

        public function update():void
        {
            var a:FlxPoint = this.armBase;
            var b:FlxPoint = new FlxPoint(this.heldDoll.pos.x * m_physScale/2,
                                          this.heldDoll.pos.y * m_physScale/2);

            var y:Number = b.y-a.y;
            var x:Number = b.x-a.x;

            var theta:Number = Math.atan2(y, x);

            var deg:Number = theta * 180 / Math.PI;
            forearm.angle = deg + 90;

            hand.x = this.heldDoll.pos.x * m_physScale / 2 - hand.width/2;
            hand.y = this.heldDoll.pos.y * m_physScale / 2 - hand.height/2;

            fingers.x = this.heldDoll.pos.x * m_physScale / 2 - fingers.width/2;
            fingers.y = this.heldDoll.pos.y * m_physScale / 2 - fingers.height/2;

            //forearm.x = this.heldDoll.pos.x * m_physScale / 2 - hand.width/2;
            forearm.y = this.heldDoll.pos.y * m_physScale / 2;
        }
    }
}
